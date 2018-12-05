//
//  File.swift
//  PinBoard
//
//  Created by echo on 5/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

struct Links : Decodable {
    let `self`: URL?
    let html: URL?
    let photos: URL?
    let likes: URL?
    enum CodingKeys : String, CodingKey {
        case `self` = "self"
        case html = "html"
        case photos = "photos"
        case likes = "likes"
    }
}
