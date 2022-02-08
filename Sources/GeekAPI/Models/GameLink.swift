//
//  GameLink.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 26/1/19.
//

import Foundation
import Codability

public enum GameLinkType: String, CodingKey, CaseIterable {
    case designers = "boardgamedesigner"
    case artists = "boardgameartist"
    case publishers = "boardgamepublisher"
    case honors = "boardgamehonor"
    case categories = "boardgamecategory"
    case mechanics = "boardgamemechanic"
    case expansions = "boardgameexpansion"
    case versions = "boardgameversion"
    case expands = "expandsboardgame"
    case integrations = "boardgameintegration"
    case contains = "contains"
    case containedIn = "containedin"
    case reimplementations = "reimplementation"
    case reimplements = "reimplements"
    case families = "boardgamefamily"
    case subDomains = "boardgamesubdomain"
}

public struct GameLink: Decodable, Hashable {

    public let name: String
    public let type: String
    public let id: String
    public let primary: Bool
    public let state: String
    public let path: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        name = try container.decode("name")
        type = try container.decode("objecttype")
        id = try container.decode("objectid")
        primary = try container.decode(Int.self, forKey: "primarylink") == 1
        state = try container.decode("itemstate")
        path = try container.decode("href")
    }
}
