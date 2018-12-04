//
//  MockCache.swift
//  DownloaderTests
//
//  Created by echo on 4/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

@testable import Downloader

/** for use in testing, to verify if the cache is accessed */
class MockCache: DataCache {
    
    /// number of times the cache was accessed
    private(set) var accessCount: Int = 0
    
    /// number of times the cache was written to
    private(set) var writeCount: Int = 0
    
    override subscript(key: Key) -> Object? {
        get {
            accessCount += 1
            return super[key]
        }
        
        set {
            writeCount += 1
            super[key] = newValue
        }
    }
    
}
