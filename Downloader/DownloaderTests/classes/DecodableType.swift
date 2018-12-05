//
//  File.swift
//  DownloaderTests
//
//  Created by echo on 5/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import Foundation


/** To test that the DownloadManager can return a Decodable object.
    The corresponding JSON is in the decodableDict.json file (test assets) */
struct DecodableType : Decodable {
    let id: Int?
    let title: String?
    let link: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case link
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(URL.self, forKey: .link)
    }
}
