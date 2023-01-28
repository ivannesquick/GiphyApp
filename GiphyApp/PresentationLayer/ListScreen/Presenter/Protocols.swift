//
//  Protocols.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

protocol ListInput: AnyObject {
    func loadCategory(gifList: GifList)
    func loadCategoryList(categoryList: CategoryList)
}

protocol ListOutput {
    func fetchCategories(offset: Int)
    func searchByCategory(offset: Int, categoryName: String)
}
