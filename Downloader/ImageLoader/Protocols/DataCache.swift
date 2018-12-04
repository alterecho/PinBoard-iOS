//
//  ImageCache.swift
//  DownloaderTests
//
//  Created by echo on 4/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

class DataCache : CacheProtocol {
    var limit: Int {
        get {
            return cache.countLimit
        }
        
        set {
            cache.countLimit = newValue
        }
    }
    
    static let shared = DataCache()
    
    typealias Key = NSURL
    typealias Object = NSData
    
    let cache = NSCache<Key, Object>()
    
    subscript(key: Key) -> Object? {
        get {
            return cache.object(forKey: key)
        }
        set {
            if let value = newValue {
                cache.setObject(value, forKey: key)
            }
            
        }
    }
}
