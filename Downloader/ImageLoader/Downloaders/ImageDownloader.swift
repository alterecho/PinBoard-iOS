//
//  ImageDownloader.swift
//  ImageLoader
//
//  Created by echo on 2/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit
class ImageDownloader : DownloaderProtocol, DownloadOperationProtocol {
    
    enum Error: Swift.Error {
        case invalidImageData
        case noData
    }
    
    let session: SessionProtocol
    var dataTask: URLSessionDataTask? = nil
    
    init(session: SessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func download(for request: URLRequest, completionHandler: @escaping (Downloadable?, Swift.Error?) -> ()) {
        func callCompletion(image: UIImage?, error: Swift.Error?) {
            DispatchQueue.main.async {
                completionHandler(image, error)
            }
        }
        
        dataTask?.cancel()
        dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Swift.Error?) in
            if let data = data {
                if let image = UIImage(data: data) {
                    callCompletion(image: image, error: nil)
                } else {
                    callCompletion(image: nil, error: Error.invalidImageData)
                }
            } else if let error = error {
                callCompletion(image: nil, error: error)
            } else {
                callCompletion(image: nil, error: Error.noData)
            }
        }
    }
    
    func download(from url: URL, completionHandler: @escaping (Downloadable?, Swift.Error?) -> ()) {
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

extension UIImage : Downloadable {}
