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
    
//    func testThatImageDownloaderDownloadsImage() {
//        let expectation = self.expectation(description: "download image")
//        //        let url = URL(string:  "https://images.unsplash.com/profile-1464495186405-68089dcd96c3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=faces&fit=crop&h=128&w=128&s=622a88097cf6661f84cd8942d851d9a2")!
//        let url = TestURLS.imageURL
//        downloader.download(from: url) { (downloadable, error) in
//            if let _ = downloadable as? UIImage {
//                expectation.fulfill()
//            } else if let error = error {
//                XCTFail(error.localizedDescription)
//            } else {
//                XCTFail("image not downloaded")
//            }
//        }
//        downloader.start()
//        
//        waitForExpectations(timeout: 5.0) { (error) in
//            
//        }
//        
//    }
    
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

