//
//  DataModel.swift
//  JsonPlaceHolderDemo
//
//  Created by Arthur on 2021/9/1.
//

import Foundation

struct Photo: Codable {
    
    let albumId: Int
    let id: Int
    let title: String
    let thumbnailUrl: String
    let url: String
    
}
