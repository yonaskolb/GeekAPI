//
//  JSONRequest.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Foundation
import Codability

extension Request {

    static func jsonRequest<T: Decodable>(path: String, method: HTTPMethod = .get, params: Params = [:], dataPath: String? = nil, function: String = #function) -> Request<T> {
        return Request<T>(path: path, method: method, params: params, function: function) { data in
            let jsonDecoder = JSONDecoder()
            jsonDecoder.userInfo[.dataPath] = dataPath
            return try jsonDecoder.decode(JSONResponse<T>.self, from: data).data
        }
    }
}

extension CodingUserInfoKey {

    fileprivate static let dataPath = CodingUserInfoKey(rawValue: "dataPath")!
}

fileprivate struct JSONResponse<T: Decodable>: Decodable {
    let data: T

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RawCodingKey.self)
        let dataPath = decoder.userInfo[.dataPath] as? String
        if let dataPath = dataPath {
            data = try container.decode(RawCodingKey(string: dataPath))
        } else {
            data = try T(from: decoder)
        }
    }
}
