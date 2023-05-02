//
//  PhotoModel.swift
//  SwiftUIIntermediateLevel
//
//  Created by Denys Nikolaichuk on 01.05.2023.
//

import Foundation

struct PhotoModel: Identifiable, Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
