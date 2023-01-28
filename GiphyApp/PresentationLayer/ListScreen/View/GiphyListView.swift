//
//  GiphyListView.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import UIKit

final class GiphyListView: UIView {
    var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 10,
                                           bottom: 0,
                                           right: 10)
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var waterfallCollectionViewFlowLayout = WaterfallCollectionViewFlowLayout()
    
    lazy var waterfallCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: waterfallCollectionViewFlowLayout
        )
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupUI()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .black
        addSubview(categoryCollectionView)
        addSubview(waterfallCollectionView)
    }
    
    func makeConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 60),
            categoryCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            categoryCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            
            waterfallCollectionView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor),
            waterfallCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            waterfallCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            waterfallCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
