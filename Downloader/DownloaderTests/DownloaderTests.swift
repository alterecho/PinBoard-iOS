//
//  File.swift
//  DownloaderTests
//
//  Created by echo on 4/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import XCTest
@testable import Downloader

class DownloaderTests<T: DownloaderProtocol & DownloadOperationProtocol> : XCTestCase {
    
    var session: MockSession!
    var cache: MockCache!
    var downloader: T!
    
    override func setUp() {
        session = MockSession()
        cache = MockCache()
        downloader = (ImageDownloader(session: session, cache: cache) as! T)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// tests if the object from cache is used instead of fetching again
    func testThatCacheIsUsed() {
        let url = TestURLS.imageURL
        downloader.download(from: url) { (downloadable, error) in
        }
        downloader.download(from: url) { (downloadable, error) in
        }
        
        // expect 2 cache access counts
        XCTAssert(cache.accessCount >= 2, "Cache not being accessed!")
        
        downloader.start()
    }
    
}

