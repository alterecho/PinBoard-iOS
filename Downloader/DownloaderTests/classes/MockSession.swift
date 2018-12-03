//
//  MockSession.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation
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
            break
            
        default:
            break
        }
    }
    
    override func cancel() {
        
    }
}
