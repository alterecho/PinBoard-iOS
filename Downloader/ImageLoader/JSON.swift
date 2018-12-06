//
//  JSON.swift
//  DownloaderTests
//
//  Created by echo on 3/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation

/// Groups types that are returned from JSON URLs
public protocol JSON {}

public typealias JSONDict = [String : Any]
public typealias JSONArray = [JSONDict]

extension Dictionary : JSON where Key == String, Value == Any {}
extension Array : JSON where Element == JSONDict {}
