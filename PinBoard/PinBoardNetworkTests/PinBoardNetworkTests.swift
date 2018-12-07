//
//  PinBoardNetworkTests.swift
//  PinBoardNetworkTests
//
//  Created by echo on 8/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import XCTest
@testable import PinBoard
@testable import Downloader

// test that are performed by making actual network calls. Used in the PinBoardNetworkTests scheme
class PinBoardNetworkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /// using URLSessionDataTask
    func testThatImagesDataIsFetchedCorrectly() {
        guard let url = URL(string: "http://pastebin.com/raw/wgkJgazE") else {
            XCTFail("Check URL!")
            return
        }
        let request = URLRequest(url: url)
        let expectation = self.expectation(description: "Download and parse ImageData")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let imageDataArray = try decoder.decode([ImageData].self, from: data)
                    print(imageDataArray)
                    XCTAssert(imageDataArray.count > 0, "No ImageData found in downloaded data")
                    expectation.fulfill()
                } catch {
                    XCTFail(error.localizedDescription)
                }
                
            } else {
                XCTFail("ERROR fetching data from \(url): \(error?.localizedDescription ?? "unknown error")")
            }
        }.resume()
        
        self.wait(for: [expectation], timeout: 10.0)
    }
    
    /// using Downloader library
    func testThatImagesDataIsFetchedCorrectlyUsingDownloaderLibrary() {
        guard let url = URL(string: "http://pastebin.com/raw/wgkJgazE") else {
            XCTFail("Check URL!")
            return
        }
        let request = URLRequest(url: url)
        DownloadManager.shared().download(with: request) { (imageDataArray: [ImageData], request, error) in
            XCTAssert(imageDataArray.count > 0, error?.localizedDescription ?? "No ImageData downloaded")
        }
    }

}
