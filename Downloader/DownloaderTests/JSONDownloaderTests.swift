//
//  JSONDownloaderTests.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import XCTest
@testable import Downloader

class JSONDownloaderTests: XCTestCase {

    var session: MockSession!
    var downloader: JSONDownloader!
    
    override func setUp() {
        session = MockSession()
        downloader = JSONDownloader(session: session)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThatJSONDownloaderDownloadsJSON() {
        let expectation = self.expectation(description: "download JSON")
        let url = TestURLS.jsonURL
        downloader.download(from: url) { (downloadable, error) in
            if (downloadable as? JSON) != nil || (downloadable as? JSONArray) != nil {
                expectation.fulfill()
            } else if let error = error {
                XCTFail(error.localizedDescription)
            } else {
                XCTFail("JSON not downloaded")
            }
        }
        downloader.start()
        
        waitForExpectations(timeout: 5.0) { (error) in
            
        }
    }
    
    

}
