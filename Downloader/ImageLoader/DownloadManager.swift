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
    public func download(with request: URLRequest, session: SessionProtocol = URLSession.shared, completionHandler: @escaping (UIImage?, Swift.Error?) -> ()) -> DownloadOperationProtocol {
        let downloader = ImageDownloader(session: session)
        downloader.download(for: request) { (downloadable, error) in
            DispatchQueue.main.async {
                completionHandler(downloadable as? UIImage, error ?? Error.unknown)
            }
        }
        return downloader
    }
    
    @discardableResult
    public func download(with request: URLRequest, session: SessionProtocol = URLSession.shared, completionHandler: @escaping (JSON?, Swift.Error?) -> Void) -> DownloadOperationProtocol {
        let downloader = JSONDownloader(session: session)
        downloader.download(for: request) { (downloadable, error) in
            DispatchQueue.main.async {
                completionHandler(downloadable as? JSON, error ?? Error.unknown)
            }
        }
        return downloader
    }
}
