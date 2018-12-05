//
//  MockSession.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit
import XCTest

@testable import Downloader


class MockSession : SessionProtocol {
    
    fileprivate var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    fileprivate var request: URLRequest?
    
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request
        self.completionHandler = completionHandler
        return DataTask(session: self)
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: URLRequest(url: url), completionHandler: completionHandler)
    }
    
}

class DataTask : URLSessionDataTask {
    
    weak var session: MockSession?
    init(session: MockSession) {
        self.session = session
    }
    
    override func resume() {
        let fileURL: URL?
        
        switch session?.request?.url {
        case TestURLS.imageURL:
            fileURL = Bundle(for: DataTask.self).url(forResource: "img", withExtension: "jpg")
             
            break
            
        case TestURLS.jsonURL:
            fileURL = Bundle(for: DataTask.self).url(forResource: "test", withExtension: "json")
            
        case TestURLS.decodableDictURL:
            fileURL = Bundle(for: DataTask.self).url(forResource: "decodableDict", withExtension: "json")
            
        case TestURLS.decodableArrayURL:
            fileURL = Bundle(for: DataTask.self).url(forResource: "decodableArray", withExtension: "json")
            
        default:
            fileURL = nil
            break
        }
        
        if let url = fileURL {
            do {
                let data = try Data(contentsOf: url)
                session?.completionHandler?(data, nil, nil)
            } catch {
                XCTFail("unable to load test file")
                session?.completionHandler?(nil, nil, nil)
            }
        } else {
            XCTFail("unable to load test file")
            session?.completionHandler?(nil, nil, nil)
        }
    }
    
    override func cancel() {
        
    }
}
