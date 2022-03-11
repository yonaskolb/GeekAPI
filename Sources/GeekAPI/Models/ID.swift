//
//  ID.swift
//  BGG
//
//  Created by Yonas Kolb on 15/1/19.
//

import Foundation

public struct ID: Decodable, Equatable, Hashable, ExpressibleByStringLiteral, CustomStringConvertible {
    public let value: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        if let int = try? container.decode(Int.self) {
            value = String(int)
        } else {
            value = try container.decode(String.self)
        }
    }

    public init(stringLiteral value: String) {
        self.value = value
    }

    public var description: String { value }
}
