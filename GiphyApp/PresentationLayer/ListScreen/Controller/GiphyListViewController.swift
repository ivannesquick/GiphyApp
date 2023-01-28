//
//  GiphyListViewController.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import UIKit

class GiphyListViewController: UIViewController {
    private var currentCategory = ""
    private var gifList: [Gif] = []
    private var categories: [Category] = []
    
    private var paginationTotalCount = 0
    private var categoryPaginationTotalCount = 0
    
    private var contentOffset = 0
    private var categoryOffset = 0
    
    private lazy var output: ListOutput = {
        ListPresenter(view: self)
    }()
    
    private var listView = GiphyListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionViews()
        fetchCategories()
    }
    
    override func loadView() {
        view = listView
    }
}

private extension GiphyListViewController {
    func configureCollectionViews() {
        listView.waterfallCollectionView.delegate = self
        listView.waterfallCollectionView.dataSource = self
        listView.waterfallCollectionView.delegate = self
        listView.waterfallCollectionViewFlowLayout.delegate = self
        listView.waterfallCollectionView.register(GifCell.self,
                                                  forCellWithReuseIdentifier: String(describing: GifCell.self))
        
        listView.categoryCollectionView.delegate = self
        listView.categoryCollectionView.dataSource = self
        listView.categoryCollectionView.register(CategoryCell.self,
                                                 forCellWithReuseIdentifier: String(describing: CategoryCell.self)
        )
    }
    
    func fetchCategories() {
        output.fetchCategories(offset: categoryOffset)
    }
    
    func fetchBy(category: String) {
        output.searchByCategory(offset: contentOffset, categoryName: category)
    }
    
    func setCurrentCategory(categoryList: CategoryList) {
        if let firstCategory = categoryList.data.first {
            currentCategory = firstCategory.name
        } else {
            currentCategory = "Trending"
        }
        fetchBy(category: currentCategory)
    }
    
    func transitionToDetailScreen(selectedGifURL: String) {
        let detailGifViewController = DetailGifViewController(currentGifUrl: selectedGifURL)
        detailGifViewController.modalTransitionStyle = .crossDissolve
        detailGifViewController.modalPresentationStyle = .overFullScreen
        present(detailGifViewController, animated: true)
    }
}

extension GiphyListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case listView.waterfallCollectionView:
            transitionToDetailScreen(selectedGifURL: gifList[indexPath.row].images.original.url)
        case listView.categoryCollectionView:
            if indexPath.row == 0 {
                fetchBy(category: currentCategory)
            } else {
                currentCategory = categories[indexPath.row].name
                fetchBy(category: currentCategory)
            }
            contentOffset = 0
            listView.waterfallCollectionView.setContentOffset(.zero, animated: true)
            gifList.removeAll()
            listView.waterfallCollectionView.reloadData()
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        switch collectionView {
        case listView.waterfallCollectionView:
            guard indexPath.row == contentOffset,
                  contentOffset <= paginationTotalCount
            else { return }
            
            contentOffset += 20
            fetchBy(category: currentCategory)
        case listView.categoryCollectionView:
            guard indexPath.row == categoryOffset,
                  categoryOffset <= categoryPaginationTotalCount
            else { return }
            
            categoryOffset += 20
            fetchCategories()
        default:
            break
        }
    }
}

extension GiphyListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case listView.waterfallCollectionView:
            return gifList.count
        case listView.categoryCollectionView:
            return categories.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case listView.waterfallCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:String(describing:GifCell.self),
                                                                for: indexPath) as? GifCell else { return UICollectionViewCell() }
            cell.fill(with: gifList[indexPath.row].images.previewGif.url)
            return cell
        case listView.categoryCollectionView:
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: CategoryCell.self),
                for: indexPath
            ) as? CategoryCell else { return UICollectionViewCell() }
            cell.tag = indexPath.row
            if cell.tag == indexPath.row {
                cell.fill(with: categories[indexPath.row].name)
            }
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension GiphyListViewController: WaterfallCollectionViewFlowLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForGifAtIndexPath indexPath: IndexPath) -> CGFloat {
        let downSized = gifList[indexPath.row].images.fixedWidthDownsampled
        let width = downSized.width
        let height = downSized.height
        
        let downloadedImageWidth = CGFloat(NSString(string: width).floatValue)
        let downloadedImageHeight = CGFloat(NSString(string: height).floatValue)
        let collectionViewHalfWidth = (collectionView.bounds.width / 2)
        let ratio = collectionViewHalfWidth / CGFloat(downloadedImageWidth)
        
        return downloadedImageHeight * ratio
    }
}

extension GiphyListViewController: ListInput {
    func loadCategory(gifList: GifList) {
        self.gifList.append(contentsOf: gifList.data)
        DispatchQueue.main.async {
            self.listView.waterfallCollectionView.reloadData()
        }
    }
    
    func loadCategoryList(categoryList: CategoryList) {
        self.categoryPaginationTotalCount = categoryList.pagination.totalCount
        self.categories.append(contentsOf: categoryList.data)
        DispatchQueue.main.async {
            self.listView.categoryCollectionView.reloadData()
        }
        setCurrentCategory(categoryList: categoryList)
    }
}
