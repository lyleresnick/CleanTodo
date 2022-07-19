//
//  ApiClient.swift
//  Todo
//
//  Created by Lyle Resnick on 2022-07-19.
//  Copyright © 2022 Lyle Resnick. All rights reserved.
//

import Foundation

struct FailureInfo : Error {
    let statusCode: Int?
    let description: String
    
    init(statusCode: Int? = nil, description: String) {
        self.statusCode = statusCode
        self.description = description
    }
    
    init(response: HTTPURLResponse) {
        self.init(statusCode: response.statusCode, description: response.description)
    }
}

protocol ApiClient {
    func all(completion: @escaping (Result<Data, FailureInfo>) -> ())
    func fetch(id: String, completion: @escaping (Result<Data, FailureInfo>) -> ())
    func create(values: TodoValues, completion: @escaping (Result<Data, FailureInfo>) -> ())
    func update(id: String, values: TodoValues, completion: @escaping (Result<Data, FailureInfo>) -> ())
    func delete(id: String, completion: @escaping (Result<Data, FailureInfo>) -> ())
}
