//
//  ApiClient.swift
//  Todo
//
//  Created by Lyle Resnick on 2022-07-19.
//  Copyright © 2022 Lyle Resnick. All rights reserved.
//

import Foundation

class NetworkApiClient: ApiClient {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    lazy var session = { () -> URLSession in
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 60.0
        sessionConfig.timeoutIntervalForResource = 180.0
        return URLSession(configuration: sessionConfig)
    }()
    
    static private let todobackendUrl = "https://todo-backend-lyle.fly.dev/api"
//    static private let todobackendUrl = "http://localhost:8080/api"
    fileprivate static let baseURL = URL(string: todobackendUrl)!

    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .formatted(formatter)
        return encoder
    }()
    
    func all(completion: @escaping (Result<Data, FailureInfo>) -> ()) {
        session.dataTask(
            with: Self.baseURL.appendingPathComponent("todo"),
            completionHandler: completionHandler(completion: completion)
        ).resume()
    }
    
    func fetch(id: String, completion: @escaping (Result<Data, FailureInfo>) -> ()) {
        session.dataTask(
            with: URLRequest(httpMethod: .get, resource: todoResource(id: id)),
            completionHandler: completionHandler(completion: completion)
        ).resume( )
    }
    
func create(params: TodoParams, completion: @escaping (Result<Data, FailureInfo>) -> ()) {
        session.uploadTask(
            with: URLRequest(httpMethod: .post, resource: "todo", uploading: true),
            from: try! encoder.encode(params), // this wont fail
            completionHandler: completionHandler(completion: completion)
        ).resume()
    }
                
    func update(id: String, params: TodoParams, completion: @escaping (Result<Data, FailureInfo>) -> ()) {
        session.uploadTask(
            with: URLRequest(httpMethod: .put, resource: todoResource(id: id), uploading: true),
            from:  try! encoder.encode(params), // this wont fail
            completionHandler: completionHandler(completion: completion)
        ).resume()
    }
    
    func delete(id: String, completion: @escaping (Result<Data, FailureInfo>) -> ()) {
        session.dataTask(
            with: URLRequest(httpMethod: .delete, resource: todoResource(id: id)),
            completionHandler: completionHandler(completion: completion)
        ).resume()
    }
    
    private func todoResource(id: String) -> String {
       return "todo/\(id)"
    }
    
    private let formatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd'T23:59:59Z'")
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    
    private func completionHandler(completion: @escaping (Result<Data, FailureInfo>) -> ()) -> ((Data?, URLResponse?, Error?) -> ()) {
        return { data, response, error in
            if let error = error {
                let nsError = error as NSError
                completion(.failure(FailureInfo(party: .client(code: nsError.code), description: error.localizedDescription)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(FailureInfo(party: .client(), description: "response is not a HTTPURLResponse")))
                return
            }
            guard response.statusCode == 200 else {
                completion(.failure(FailureInfo(response: response)))
                return
            }
            guard let data = data else {
                completion(.failure(FailureInfo(party: .client(), description: "Data is nil")))
                return
            }
            completion(.success(data))
        }
    }
}

private extension URLRequest {
    init(httpMethod: NetworkApiClient.HTTPMethod, resource: String, uploading: Bool = false) {
        self.init(url: NetworkApiClient.baseURL.appendingPathComponent(resource))
        self.httpMethod = httpMethod.rawValue
        if uploading {
            self.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
    }
}
