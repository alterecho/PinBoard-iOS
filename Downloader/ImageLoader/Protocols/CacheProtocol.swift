//
//  CacheProtocol.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

protocol CacheProtocol {
    associatedtype Key
    associatedtype Object
    
    /// max number of objects that the cache can hold
    var limit: Int { get set }
    
    subscript(key: Key) -> Object? { get set }
}
