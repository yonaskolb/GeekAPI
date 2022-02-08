//
//  Forum.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

public struct Forum: Decodable, Hashable {

    public let id: ID
    public let title: String
    public let threadCount: Int
    public let postCount: Int

    enum CodingKeys: String, CodingKey {
        case id = "forumid"
        case title = "title"
        case threadCount = "numthreads"
        case postCount = "numposts"
    }
}
