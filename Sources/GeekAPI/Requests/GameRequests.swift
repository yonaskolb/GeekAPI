//
//  GetItemRequest.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Foundation

extension Request {

    public static func getGame(id: ID) -> Request<Game> {
        let params: Params = [
            "objectid": id.value,
            "objecttype": "thing",
        ]
        return .jsonRequest(path: "geekitems", params: params, dataPath: "item")
    }
}
