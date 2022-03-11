//
//  ImageRequests.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

extension Request {

    public static func getImages(id: ID, gallery: ImageGallery = .all, size: ImageSize? = nil, page: Int? = nil, count: Int = 1, tag: String? = nil) -> Request<ImagesResponse> {
        var params: Params = [
            "objectid": id.value,
            "objecttype": "thing",
            "showcount": count,
            "galleries[]": gallery.rawValue,
            "sort": "hot",
            ]
        if let size = size {
            params["size"] = size.rawValue
        }
        if let page = page {
            params["pageid"] = page
        }
        if let tag = tag {
            params["tag"] = tag
        }
        return .jsonRequest(path: "images", params: params)
    }

    public static func getImage(id: ID) -> Request<ImageResponse> {
        return .jsonRequest(path: "images/\(id)")
    }
}
