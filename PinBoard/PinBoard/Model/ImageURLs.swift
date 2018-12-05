//
//  ImageURLs.swift
//  PinBoard
//
//  Created by echo on 5/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

struct ImageURLS : Decodable {
    let raw: URL?
    let full: URL?
    let regular: URL?
    let small: URL?
    let thumb: URL?
}
