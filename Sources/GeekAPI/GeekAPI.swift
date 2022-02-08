//
//  GeekAPI.swift
//  Geek
//
//  Created by Yonas Kolb on 8/5/18.
//  Copyright © 2018 Yonas Kolb. All rights reserved.
//

import Combine

// A list of BGG apis:
// 'files': 'files',
// 'geekitems': 'geekitems',
// 'images': 'images',
// 'threads': 'forums/threads',
// 'videos': 'videos',
// 'hotness': 'hotness',
// 'dynamicinfo': 'dynamicinfo',
// 'subtypeinfo': 'subtypeinfo',
// 'bggstore': 'bggstore',
// 'geekbay': 'geekbay',
// 'geekmarket': '/geekmarket/api/v1',
// 'geeklists': 'geeklists',
// 'reviews': 'reviews',
// 'collections': 'collections',
// 'linkeditems': 'geekitem/linkeditems'

public class GeekAPI {

    public static let shared = GeekAPI()
    public let networkClient: NetworkClient

    public init(networkClient: NetworkClient = NetworkClient(baseURL: "https://api.geekdo.com/api")) {
        self.networkClient = networkClient
    }

    public func makeRequest<T>(_ request: Request<T>, completion: @escaping (RequestResult<T>) -> Void) {
        networkClient.makeRequest(request) { result in
            completion(result)
        }
    }

    public func makeRequest<T>(_ request: Request<T>) -> Future<T, RequestError> {
        return networkClient.makeRequest(request)
    }
}
