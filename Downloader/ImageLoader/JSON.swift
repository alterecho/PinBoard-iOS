//
//  JSON.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

public protocol JSON {}

typealias JSONDict = [String : Any]
typealias JSONArray = [JSONDict]

extension Dictionary : JSON {}
extension Array : JSON {}
