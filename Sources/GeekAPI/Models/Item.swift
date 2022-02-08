//
//  Item.swift
//  BGG
//
//  Created by Yonas Kolb on 15/1/19.
//

import Foundation
import Codability

public struct HotlistItem: Decodable, Hashable {

    public let item: Item
    public let image: URL?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        image = try container.decodeIfPresent("imageurl")
        item = try Item(from: decoder)
    }
}

public struct Item: Decodable, Hashable {

    public let id: ID
    public let name: String
    public let path: String
    public let yearPublished: String

    enum CodingKeys: String, CodingKey {
        case id = "objectid"
        case name = "name"
        case yearPublished = "yearpublished"
        case path = "href"
    }
}

extension Item: CustomStringConvertible {

    public var description: String {
        return "\(name) \(yearPublished) (\(id.value))"
    }
}
