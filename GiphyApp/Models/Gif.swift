//
//  Gif.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

struct Gif: Decodable {
    let images: GifDescription
    let id: String
}
