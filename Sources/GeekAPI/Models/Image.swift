//
//  ItemImages.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Foundation
import Codability

public struct ImagesResponse: Decodable {

    public let images: [Image]

}

public struct ImageResponse: Decodable {

    public let sizes: [ImageSize: URL]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        var images: [ImageSize: URL] = [:]
        let imagesContainer = try container.nestedContainer(keyedBy: ImageSize.self, forKey: "images")
        for imageSize in ImageSize.allCases {
            if imagesContainer.contains(imageSize) {
                let imageContainer = try imagesContainer.nestedContainer(keyedBy: RawCodingKey.self, forKey: imageSize)
                let url: URL = try imageContainer.decode("url")
                images[imageSize] = url
            }
        }
        self.sizes = images
    }
}

public protocol ImagesContainer {
    var id: ID { get }
    var images: [ImageSize: URL] { get }
}

extension Game: ImagesContainer {
    public var id: ID { item.id }
}
extension Video: ImagesContainer {}

public struct Image: Decodable {

    public let id: ID
    public let url: URL
    public let largeURL: URL

    enum CodingKeys: String, CodingKey {
        case id = "imageid"
        case url = "imageurl"
        case largeURL = "imageurl_lg"
    }
}

public enum ImageGallery: String {
    case all
    case game
    case people
    case creative
}

public enum ImageSize: String, CodingKey, CaseIterable {

    case thumb
    case micro
    case square
    case squareFit = "squarefit"
    case tallThumb = "tallthumb"
    case previewThumb = "previewthumb"
    case square200
    case large
    case original
}
