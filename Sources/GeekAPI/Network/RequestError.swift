//
//  RequestError.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Foundation

public enum RequestError: Error, CustomStringConvertible {
    case network(Error)
    case apiError(Int, String?)
    case decodingError(Error)
    case invalidRequest(String)

    public var description: String {
        switch self {
        case let .network(error): return "Network error:\n\n\(error.localizedDescription)"
        case let .apiError(statusCode, string): return "API returned \(statusCode)\(string != nil ? ":\n\n\(string!)" : "")"
        case let .decodingError(error): return "Decoding Error:\n\n\(error)"
        case let .invalidRequest(path): return "Request \(path) was invalid"
        }
    }
}
