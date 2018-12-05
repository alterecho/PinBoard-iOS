//
//  File.swift
//  PinBoard
//
//  Created by echo on 5/12/18.
//  Copyright © 2018 echo. All rights reserved.
//

import CoreGraphics

struct ImageData : Decodable{
    let id: String
    let dateCreatedString: String
    //    let dateCreated: Date
    let size: CGSize
    let colorHex: String
    let likes: Int
    let likedByUser: Bool
    let user: User?
    let urls: ImageURLS?
    let categories: [ImageCategory]?
    let links: Links?
    
    enum CodingKeys : String, CodingKey {
        case id
        case dateCreatedString = "created_at"
        case width
        case height
        case color
        case likes
        case likedByUser = "liked_by_user"
        case user
        case urls
        case categories
        case links
    }
    
    init(from decoder: Decoder) throws {
        do {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
            dateCreatedString = try container.decode(String.self, forKey: .id)
            let width = try container.decodeIfPresent(CGFloat.self, forKey: .width)
            let height = try container.decodeIfPresent(CGFloat.self, forKey: .height)
            size = CGSize(width: width ?? 0.0, height: height ?? 0.0)
            colorHex = try container.decode(String.self, forKey: .color)
            likes = try container.decode(Int.self, forKey: .likes)
            likedByUser = try container.decode(Bool.self, forKey: .likedByUser)
            user = try container.decode(User.self, forKey: .user)
            urls = try container.decodeIfPresent(ImageURLS.self, forKey: .urls)
            categories = try container.decodeIfPresent([ImageCategory].self, forKey: .categories)
            links = try container.decode(Links.self, forKey: .links)
        } catch {
            print(error)
            throw error
        }
    }
}
