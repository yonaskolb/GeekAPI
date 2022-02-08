//
//  Video.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 28/1/19.
//

import Foundation
import Codability

public struct Video: Decodable, Hashable {

    public let id: ID
    public let title: String
    public let type: String
    public let images: [ImageSize: URL]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        id = try container.decode("videoid")
        title = try container.decode("title")
        type = try container.decode("gallery")

        var images: [ImageSize: URL] = [:]
        let imagesContainer = try container.nestedContainer(keyedBy: ImageSize.self, forKey: "images")
        for imageSize in ImageSize.allCases {
            if let url: URL = try imagesContainer.decodeIfPresent(imageSize) {
                images[imageSize] = url
            }
        }
        self.images = images
    }
}
