//
//  JsonDownloader.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

/** downloads any JSON or JSON array from the supplied URL */
class JSONDownloader : DownloaderProtocol, DownloadOperationProtocol {
    typealias CacheType = DataCache
    
    enum Error: Swift.Error {
        case invalidJSONData
        case noData
    }
    
    private let session: SessionProtocol
    private let cache: CacheType
    private var dataTask: URLSessionDataTask? = nil
    
    required init(session: SessionProtocol = URLSession.shared, cache: CacheType = DataCache.shared) {
        self.session = session
        self.cache = cache
    }
    
    func download(for request: URLRequest, completionHandler: @escaping (Downloadable?, Swift.Error?) -> ()) {
        /// calls the completionHandler on the main thread
        func callCompletion(json: Downloadable?, error: Swift.Error?) {
            DispatchQueue.main.async {
                completionHandler(json, error)
            }
        }
        
        /// returns the parameters that can be used to call the completionHandler method
        func completionHandlerParametersForData(data: Data) -> (json: Downloadable?, error: Swift.Error?) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                if let json = json as? JSONDict {
                    return (json, nil)
                } else if let json = json as? JSONArray {
                    return (json , nil)
                } else {
                    return (nil , Error.invalidJSONData)
                }
            } catch {
                return (nil, error)
            }
        }
        
        // check cache
        if let url = request.url, let data = cache[url as NSURL] {
            let params = completionHandlerParametersForData(data: data as Data)
            if let json = params.json {
                callCompletion(json: json, error: params.error)
                return
            }
        }
        
        dataTask?.cancel()
        dataTask = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Swift.Error?) in
            
            if let data = data {
                let params = completionHandlerParametersForData(data: data as Data)
                callCompletion(json: params.json, error: params.error)
            } else if let error = error {
                callCompletion(json: nil, error: error)
            } else {
                callCompletion(json: nil, error: Error.noData)
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

extension Dictionary : Downloadable where Key == String, Value == Any { }

extension Array : Downloadable where Element == JSONDict { }
