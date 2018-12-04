//
//  DownloadManagerTests.swift
//  DownloaderTests
//
//  Created by echo on 4/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import XCTest
@testable import Downloader

class DownloadManagerTests: XCTestCase {
    
    var session: MockSession!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = MockSession()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testImageDownloads() {
        let expectation = self.expectation(description: "UIImage not downloaded")
        let request = URLRequest(url: TestURLS.imageURL)
        DownloadManager.shared().download(with: request, session: session) { (image: UIImage?, error) -> () in
            if let _ = image {
                expectation.fulfill()
            } else {
                XCTFail(error?.localizedDescription ?? expectation.description)
            }
        }.start()
        
        waitForExpectations(timeout: 5.0) { (error) in
            
        }
    }
    
    func testJSONDownloads() {
        
        let expectation = self.expectation(description: "JSON not downloaded")
        let request = URLRequest(url: TestURLS.jsonURL)
        
        DownloadManager.shared().download(with: request, session: session) { (json: JSON?, error) in
            if let _ = json {
                expectation.fulfill()
            } else {
                XCTFail(error?.localizedDescription ?? expectation.description)
            }
            
        }.start()
        
        waitForExpectations(timeout: 5.0) { (error) in
            
        }
    }
}
