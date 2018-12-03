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
        switch session?.request?.url {
            
        case TestURLS.imageURL:
            if let url = Bundle(for: DataTask.self).url(forResource: "img", withExtension: "jpg") {
                do {
                    let data = try Data(contentsOf: url)
                    session?.completionHandler?(data, nil, nil)
                } catch {
                    XCTFail("unable to load test image")
                    session?.completionHandler?(nil, nil, nil)
                }
            } else {
                XCTFail("unable to load local test image")
                session?.completionHandler?(nil, nil, nil)
            }
            break
            
        case TestURLS.jsonURL:
            if let url = Bundle(for: DataTask.self).url(forResource: "test", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    session?.completionHandler?(data, nil, nil)
                } catch {
                    XCTFail("unable to load test json")
                    session?.completionHandler?(nil, nil, nil)
                }
            } else {
                XCTFail("unable to load test json")
                session?.completionHandler?(nil, nil, nil)
            }
            
        default:
            break
        }
    }
    
    override func cancel() {
        
    }
}
