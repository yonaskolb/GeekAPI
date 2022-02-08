//
//  APIRequest.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Foundation

typealias Params = [String: Any?]

public struct Request<T> {

    public let name: String
    public let path: String
    public let method: HTTPMethod
    public let headers: [String: String]
    public let params: [String: Any?]
    public let decode: (Data) throws -> T

    init(name: String? = nil, path: String, method: HTTPMethod = .get, params: Params = [:], headers: [String: String] = [:], function: String = #function, decode: @escaping (Data) throws -> T) {
        self.name = name ?? function
        self.path = path
        self.method = method
        self.params = params
        self.headers = headers
        self.decode = decode
    }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
