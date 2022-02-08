//
//  User.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

public struct User: Decodable, Hashable {

    public let username: String
    public let avatar: URL?
    public let country: String?

    enum CodingKeys: String, CodingKey {
        case username
        case avatar = "avatarurl_md"
        case country
    }
}
