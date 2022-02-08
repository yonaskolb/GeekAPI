//
//  CollectionRequests.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

extension Request {

    public static func getCollections(id: ID, onlyRatings: Bool, onlyComments: Bool, rating: Int? = nil, sort: CollectionSort, count: Int, page: Int = 1) -> Request<[CollectionItem]> {
        var params: Params = [:]
        params["objectid"] = id.value
        params["objecttype"] = "thing"
        params["rated"] = onlyRatings ? 1 : nil
        params["comment"] = onlyComments ? 1 : nil
        params["showcount"] = count
        params["pageid"] = page
        params["sort"] = sort.rawValue
        params["rating"] = rating

        return .jsonRequest(path: "collections", params: params, dataPath: "items")
    }
}

public enum CollectionSort: String {
    case date = "review_tstamp"
    case rating = "rating"
}
