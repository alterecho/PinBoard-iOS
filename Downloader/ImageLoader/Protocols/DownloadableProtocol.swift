//
//  DownloadableProtocol.swift
//  ImageLoader
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

/** extend types to conform to this protocol, to classify/mark it as downloadable (Used by the downloaders).
    example: `extension UIImage : Downloadable {}` in ImageDownloader class
 */
protocol DownloadableProtocol { }

typealias Downloadable = DownloadableProtocol
