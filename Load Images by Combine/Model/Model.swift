//
//  Model.swift
//  Load Images by Combine
//
//  Created by Dmitry Novosyolov on 20/01/2020.
//  Copyright © 2020 Dmitry Novosyolov. All rights reserved.
//

import Foundation

struct Album: Codable, Identifiable {
    let id: Int
    let title: String
}

struct Photo: Codable, Identifiable {
    let id, albumId: Int
    let title, url, thumbnailUrl: String
}
