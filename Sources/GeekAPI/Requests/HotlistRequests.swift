//
//  HotlistRequests.swift
//  GeekAPI
//
//  Created by Yonas Kolb on 27/1/19.
//

import Foundation

extension Request {

    public static var getHotlist: Request<[HotlistItem]> {
        return .jsonRequest(path: "hotness", dataPath: "items")
    }
}
