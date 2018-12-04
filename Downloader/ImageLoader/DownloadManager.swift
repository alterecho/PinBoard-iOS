//
//  DownloadManager.swift
//  DownloaderTests
//
//  Created by echo on 4/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import UIKit

class DownloadManager {
    
    enum Error : Swift.Error {
        case unknown
    }
    
    private static var sharedInstance: DownloadManager!
    
    static func shared() -> DownloadManager {
        if sharedInstance == nil {
            return DownloadManager()
        }
        return sharedInstance
    }
    
    init() {
        DownloadManager.sharedInstance = self
    }
    
    func download(from url: URL, completionHandler: (UIImage?, Swift.Error?) -> ()) -> DownloadOperationProtocol {
        func callCompletionHandler(image: UIImage?, error: Swift.Error) {
            
        }
        
        completionHandler(UIImage(named: ""), nil)
        let downloader = ImageDownloader()
        downloader.download(for: URLRequest(url: url)) { (downloadable, error) in
            DispatchQueue.main.async {
                callCompletionHandler(image: downloadable as? UIImage, error: error ?? Error.unknown)
            }
        }
        return downloader
    }
    
    func download(url: URL, completionHandler: (JSON?, Swift.Error?) -> Void) -> DownloadOperationProtocol {
        func callCompletionHandler(image: JSON?, error: Swift.Error) {
            
        }
        
        completionHandler(JSON(), nil)
        let downloader = JSONDownloader()
        downloader.download(for: URLRequest(url: url)) { (downloadable, error) in
            DispatchQueue.main.async {
                callCompletionHandler(image: downloadable as? JSON, error: error ?? Error.unknown)
            }
        }
        return downloader
    }
}
