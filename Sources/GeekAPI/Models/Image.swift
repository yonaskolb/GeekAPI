//
//  ItemImages.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Foundation

public struct ImagesResponse: Decodable {

    public let images: [Image]

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

    case thumb = "thumb"
    case micro = "micro"
    case square = "square"
    case squareFit = "squarefit"
    case tallThumb = "tallthumb"
    case previewThumb = "previewthumb"
    case square200 = "square200"

}
