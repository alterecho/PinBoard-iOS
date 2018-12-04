//
//  DownloaderTests.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import XCTest
@testable import Downloader

class ImageDownloaderTests: DownloaderTests<ImageDownloader> {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = MockSession()
        cache = MockCache()
        downloader = ImageDownloader(session: session, cache: cache)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatImageDownloaderDownloadsImage() {
        let expectation = self.expectation(description: "download image")
        let url = TestURLS.imageURL
        downloader.download(from: url) { (downloadable, error) in
            if let _ = downloadable as? UIImage {
                expectation.fulfill()
            } else if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                XCTFail("image not downloaded")
            }
        }
        downloader.start()
        
        waitForExpectations(timeout: 5.0) { (error) in
            
        }
        
    }

}
