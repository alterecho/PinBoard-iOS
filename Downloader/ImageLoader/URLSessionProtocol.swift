//
//  URLSessionProtocol.swift
//  Downloader
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

/** for dependency injection */
protocol SessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

/** URLSession conformance to SessionProtocol. Already implements the methods */
extension URLSession : SessionProtocol {
    
}
