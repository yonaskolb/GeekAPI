//
//  ForumRequests.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

extension Request {

    public static func getForums(id: ID) -> Request<[Forum]> {
        var params: Params = [:]
        params["objectid"] = id.value
        params["objecttype"] = "thing"
        return .jsonRequest(path: "forums", params: params, dataPath: "forums")
    }
}
