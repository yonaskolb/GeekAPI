//
//  Collection.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation
import Codability

public struct CollectionItem: Decodable, Hashable {

    public let user: User
    public let rating: Int?
    public let comment: String?

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        user = try container.decode("user")
        rating = try container.decodeIfPresent(Double.self, forKey: "rating").flatMap(Int.init)

        let textFieldContainer = try container.nestedContainer(keyedBy: RawCodingKey.self, forKey: "textfield")
        let commentContainer = try textFieldContainer.nestedContainer(keyedBy: RawCodingKey.self, forKey: "comment")

        comment = try commentContainer.decodeIfPresent("value")
    }
}
