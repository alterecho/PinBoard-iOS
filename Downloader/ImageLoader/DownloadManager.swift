//
//  DownloadManager.swift
//  DownloaderTests
//
//  Created by echo on 4/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit

public class DownloadManager {
    
    enum Error : Swift.Error {
        case unknown
    }
    
    private static var sharedInstance: DownloadManager!
    
    public static func shared() -> DownloadManager {
        if sharedInstance == nil {
            return DownloadManager()
        }
        return sharedInstance
    }
    
    private init() {
        DownloadManager.sharedInstance = self
    }
    
    @discardableResult
    public func download(with request: URLRequest, session: SessionProtocol = URLSession.shared, completionHandler: @escaping (UIImage?, URLRequest?, Swift.Error?) -> ()) -> DownloadOperationProtocol {
        let downloader = ImageDownloader(session: session)
        downloader.download(for: request) { (downloadable, error) in
            DispatchQueue.main.async {
                completionHandler(downloadable as? UIImage, request, error ?? Error.unknown)
            }
        }
        return downloader
    }
    
    @discardableResult
    public func download(with request: URLRequest, session: SessionProtocol = URLSession.shared, completionHandler: @escaping (JSON?, URLRequest?, Swift.Error?) -> Void) -> DownloadOperationProtocol {
        let downloader = JSONDownloader(session: session)
        downloader.download(for: request) { (downloadable, error) in
            DispatchQueue.main.async {
                completionHandler(downloadable as? JSON, request, error ?? Error.unknown)
            }
        }
        return downloader
    }
    
    @discardableResult
    public func download<T: Decodable>(with request: URLRequest, session: SessionProtocol = URLSession.shared, completionHandler: @escaping (_ type: [T], URLRequest?, Swift.Error?) -> Void) -> DownloadOperationProtocol {

        var decodableArr = [T]()
        var err: Swift.Error?
        let downloader = DownloadManager.shared().download(with: request, session: session) { (json: JSON?, request, error) in
            err = error
            if let jsonArray = json as? JSONArray {
                for json in jsonArray {
                    do {
                        let data = try JSONSerialization.data(withJSONObject: json)
                        let decoder = JSONDecoder()
                        let decodable = try decoder.decode(T.self, from: data)
                        decodableArr.append(decodable)
                    } catch {
                        print(error)
                        err = error
                    }
                }
            } else if let json = json as? JSONDict {
                do {
                    let data = try JSONSerialization.data(withJSONObject: json)
                    let decoder = JSONDecoder()
                    print("????????????")
                    let decodable = try decoder.decode(T.self, from: data)
                    print("<<<<<<<<<<<<<<")
                    print(T.self)
                    decodableArr.append(decodable)
                } catch {
                    print(error)
                    err = error
                }
            } else {
                print(error?.localizedDescription ?? "Unknown error")
                err = Error.unknown
            }
            print(decodableArr)
            DispatchQueue.main.async {
                completionHandler(decodableArr, request, err)
            }
        }
        
        
        
        
        return downloader
    }
}
