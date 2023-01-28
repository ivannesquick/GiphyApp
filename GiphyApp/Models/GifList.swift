//
//  GifList.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

struct GifList: Decodable {
    let data: [Gif]
    let pagination: Pagination
}
