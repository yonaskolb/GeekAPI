//
//  NetworkClient.swift
//  BGG
//
//  Created by Yonas Kolb on 15/1/19.
//

import Foundation
import Combine

public class NetworkClient {

    let baseURL: String
    let urlSession: URLSession

    public init(baseURL: String, urlSession: URLSession = .shared) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }

    public func makeRequest<T>(_ request: Request<T>) -> Future<T, RequestError> {
        Future { completion in
            self.makeRequest(request) { result in
                completion(result)
            }
        }
    }

    @discardableResult
    public func makeRequest<T>(_ request: Request<T>, completion: @escaping (RequestResult<T>) -> Void) -> URLSessionDataTask? {

        func fail(_ error: RequestError) {
            //print("\(request.name) failed: \(error)")
            complete(.failure(error))
        }

        func complete(_ result: RequestResult<T>) {
            completion(result)
        }

        guard var urlComponents = URLComponents(string: "\(baseURL)/\(request.path)") else {
            fail(.invalidRequest(request.path))
            return nil
        }
        urlComponents.query = request.params
            .compactMap { key, value -> (String, Any)? in
                guard let value = value else { return nil }
                return (key, value)
            }
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
        guard let url = urlComponents.url else {
            fail(.invalidRequest(request.path))
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        //print("\(request.name) request: \(url)")
        let dataTask = urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in

            if let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode,
                !(statusCode.description.hasPrefix("2") || statusCode.description.hasPrefix("3")) {
                let errorString = data.flatMap { String(data: $0, encoding: .utf8)}
                fail(.apiError(statusCode, errorString))
            } else if let error = error {
                fail(.network(error))
            } else if let data = data {
                do {
                    let value = try request.decode(data)
                    //print("\(request.name) success:")
                    //dump(value)
                    complete(.success(value))
                } catch {
                    fail(.decodingError(error))
                }
            }
        }

        dataTask.resume()
        return dataTask
    }
}

public typealias RequestResult<T> = Result<T, RequestError>
