//
//  ListPresenter.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import UIKit

final class ListPresenter {
    weak var view: ListInput?
    
    init(view: ListInput) {
        self.view = view
    }
}

extension ListPresenter: ListOutput {
    func fetchCategories(offset: Int) {
        NetworkService.shared.sendRequest(request: GifListEndpoint.categories.request(offset: offset), responseModel: CategoryList.self) { result in
            switch result {
            case .success(let categories):
                self.view?.loadCategoryList(categoryList: categories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchByCategory(offset: Int, categoryName: String) {
        NetworkService.shared.sendRequest(request: GifListEndpoint.search(categoryName).request(offset: offset),
                                    responseModel: GifList.self) { result in
            switch result {
            case .success(let gifList):
                self.view?.loadCategory(gifList: gifList)
            case .failure(let error):
                print(error)
            }
        }
    }
}
