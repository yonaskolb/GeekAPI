//
//  VideoRequests.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 28/1/19.
//

import Foundation

extension Request {

    public static func getVideos(id: ID) -> Request<[Video]> {
        var params: Params = [:]
        params["objectid"] = id.value
        params["objecttype"] = "thing"
        return .jsonRequest(path: "videos", params: params, dataPath: "videos")
    }
}
