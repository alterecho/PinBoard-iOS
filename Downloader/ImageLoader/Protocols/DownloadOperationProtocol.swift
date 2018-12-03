//
//  DownloadOperation.swift
//  ImageLoader
//
//  Created by echo on 2/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

protocol DownloadOperationProtocol {
    func start()
    func pause()
    func cancel()
}
