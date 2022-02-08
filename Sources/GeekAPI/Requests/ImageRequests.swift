//
//  ImageRequests.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

extension Request {

    public static func getImages(id: ID, gallery: ImageGallery = .all, size: ImageSize? = nil, page: Int? = nil, count: Int = 1) -> Request<ImagesResponse> {
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
        return .jsonRequest(path: "images", params: params)
    }
}
