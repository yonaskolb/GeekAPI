//
//  Game.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 26/1/19.
//

import Foundation
import Codability

public struct Game: Decodable, Hashable {

    public let itemID: ID
    public let item: Item

    public let longDescription: String
    public let metadata: Metadata
    public let links: [GameLinkType: [GameLink]]
    public let images: [ImageSize: URL]

    public struct Metadata: Decodable, Hashable {

        public let minPlayers: Int?
        public let maxPlayers: Int?

        public let minPlayTime: Int?
        public let maxPlayTime: Int?

        public let minAge: Int?

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: RawCodingKey.self)
            minPlayers = try container.decodeIfPresent(String.self, forKey: "minplayers").flatMap(Int.init)
            maxPlayers = try container.decodeIfPresent(String.self, forKey: "maxplayers").flatMap(Int.init)
            minPlayTime = try container.decodeIfPresent(String.self, forKey: "minplaytime").flatMap(Int.init)
            maxPlayTime = try container.decodeIfPresent(String.self, forKey: "maxplaytime").flatMap(Int.init)
            minAge = try container.decodeIfPresent(String.self, forKey: "minage").flatMap(Int.init)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        item = try Item(from: decoder)
        itemID = try container.decode("itemid")
        longDescription = try container.decodeIfPresent("description") ?? ""

        var links: [GameLinkType: [GameLink]] = [:]
        let linksContainer = try container.nestedContainer(keyedBy: GameLinkType.self, forKey: "links")
        for linkKey in GameLinkType.allCases {
            let linkList: [GameLink] = try linksContainer.decode(linkKey)
            links[linkKey] = linkList
        }
        self.links = links

        var images: [ImageSize: URL] = [:]
        let imagesContainer = try container.nestedContainer(keyedBy: ImageSize.self, forKey: "images")
        for imageSize in ImageSize.allCases {
            if let url: URL = try imagesContainer.decodeIfPresent(imageSize) {
                images[imageSize] = url
            }
        }
        self.images = images

        metadata = try Metadata.init(from: decoder)
    }
}

extension Game {

    public func getLinks(_ type: GameLinkType) -> [GameLink] {
        return links[type] ?? []
    }
}


