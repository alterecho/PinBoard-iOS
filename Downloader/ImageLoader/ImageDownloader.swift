//
//  ImageDownloader.swift
//  ImageLoader
//
//  Created by echo on 2/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit
class ImageDownloader : DownloaderProtocol, DownloadOperationProtocol {
    let session: URLSession
    var dataTask: URLSessionDataTask? = nil
    
    init() {
        session = URLSession.shared
    }
    
    func download(for request: URLRequest, completionHandler: @escaping (Downloadable?, Error?) -> ()) {
        func callCompletion(image: UIImage?, error: Error?) {
            DispatchQueue.main.async {
                completionHandler(image, error)
            }
        }
        
        dataTask?.cancel()
        dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data {
                if let image = UIImage(data: data) {
                    callCompletion(image: image, error: nil)
                } else {
                    
                }
            } else if let error = error {
                callCompletion(image: nil, error: error)
            } else {
                callCompletion(image: nil, error: nil)
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

extension UIImage : Downloadable {}
