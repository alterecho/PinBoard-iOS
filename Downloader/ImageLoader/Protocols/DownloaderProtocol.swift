//
//  DownloaderProtocol.swift
//  ImageLoader
//
//  Created by echo on 2/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

protocol DownloaderProtocol: class {
    associatedtype CacheType: CacheProtocol
    init(session: SessionProtocol, cache: CacheType)
    func download(from url: URL, completionHandler: @escaping (Downloadable?, Error?) -> ())
    func download(for request: URLRequest, completionHandler: @escaping (Downloadable?, Error?) -> ())
}

