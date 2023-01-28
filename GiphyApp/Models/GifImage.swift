//
//  GifImage.swift
//  GiphyApp
//
//  Created by Иван Нескин on 28.01.2023.
//

import Foundation

struct GifDescription: Decodable {
    let original: GifImageParameters
    let fixedWidthDownsampled: GifImageParameters
    let previewGif: GifImageParameters
    
    enum CodingKeys: String, CodingKey {
        case previewGif = "preview_gif"
        case original
        case fixedWidthDownsampled = "fixed_width_downsampled"
    }
}

struct GifImageParameters: Decodable {
    let height: String
    let width: String
    let url: String
}
