//
//  DetailGifPresenter.swift
//  GiphyApp
//
//  Created by Иван Нескин on 29.01.2023.
//

import Foundation

final class DetailGifPresenter {
    weak var view: DetailGifInput?
    
    init(view: DetailGifInput) {
        self.view = view
    }
}

extension DetailGifPresenter: DetailGifOutput {}
