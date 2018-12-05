//
//  ImageCategory.swift
//  PinBoard
//
//  Created by echo on 5/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

struct ImageCategory : Decodable {
    let id: Int
    let title: String
    let photoCount: Int
    let links: Links
    
    enum CodingKeys : String, CodingKey {
        case id
        case title
        case photoCount = "photo_count"
        case links
    }
}
