//
//  Photo.swift
//  BostaTask
//
//  Created by Aya Mashaly on 10/03/2025.
//

import Foundation

struct Photo: Decodable {
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
