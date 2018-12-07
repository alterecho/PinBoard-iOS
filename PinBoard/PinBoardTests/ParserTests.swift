//
//  PinBoardTests.swift
//  PinBoardTests
//
//  Created by echo on 8/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import XCTest
@testable import PinBoard

class PinBoardTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecoding<T: Decodable>(for decodableClass: T.Type, fromFileWithName filename: String) -> T? {
        guard let fileURL = Bundle(for: PinBoardTests.self).url(forResource: filename, withExtension: nil) else {
            XCTFail("Local ImageData file not found")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            return try decoder.decode(decodableClass, from: data)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
        return nil
    }

    func testImageDataArrayParsing() {
        XCTAssertNotNil(self.testDecoding(for: [ImageData].self, fromFileWithName: "ImageDataArray.json"), "unable to parse local  ImageData array json")
    }
    
    func testImageDataParsing() {
        XCTAssertNotNil(self.testDecoding(for: ImageData.self, fromFileWithName: "ImageData.json"), "unable to parse local ImageData json")
    }

}
