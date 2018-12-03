//
//  SingletonProtocol.swift
//  ImageLoader
//
//  Created by echo on 2/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

protocol SingletonProtocol {
    static func shared<T>() -> T
}
