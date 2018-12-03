//
//  JsonDownloader.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

class JSONDownloader : DownloaderProtocol, DownloadOperationProtocol {
    let session: SessionProtocol
    var dataTask: URLSessionDataTask? = nil
    
    init(session: SessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func download(for request: URLRequest, completionHandler: @escaping (Downloadable?, Error?) -> ()) {
        func callCompletion(json: JSON?, error: Error?) {
            DispatchQueue.main.async {
                completionHandler(json, error)
            }
        }
        
        dataTask?.cancel()
        dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] {
                        callCompletion(json: json, error: nil)
                    } else {
                        callCompletion(json: nil, error: error)
                    }
                } catch {
                    callCompletion(json: nil, error: error)
                }
            } else if let error = error {
                callCompletion(json: nil, error: error)
            } else {
                callCompletion(json: nil, error: nil)
            }
        }
    }
    
    func download(from url: URL, completionHandler: @escaping (Downloadable?, Error?) -> ()) {
        let request = URLRequest(url: url)
        self.download(for: request, completionHandler: completionHandler)
    }
    
    
    func start() {
        dataTask?.resume()
    }
    
    func pause() {
        
    }
    
    func cancel() {
        dataTask?.cancel()
    }
}

extension Dictionary : Downloadable {
    
}
