//
//  ApiClient.swift
//  Todo
//
//  Created by Lyle Resnick on 2022-07-19.
//  Copyright © 2022 Lyle Resnick. All rights reserved.
//

import Foundation

enum NetworkFailureParty {
    case client(code: Int? = nil)
    case server(code: Int)
}
struct FailureInfo : Error {
    let party: NetworkFailureParty
    let description: String
    
    init(party: NetworkFailureParty, description: String) {
        self.party = party
        self.description = description
    }
    
    init(response: HTTPURLResponse) {
        self.init(party: .server(code: response.statusCode), description: response.description)
    }
}

protocol ApiClient {
    func all(completion: @escaping (Result<Data, FailureInfo>) -> ())
    func fetch(id: String, completion: @escaping (Result<Data, FailureInfo>) -> ())
    func create(params: TodoParams, completion: @escaping (Result<Data, FailureInfo>) -> ())
    func update(id: String, params: TodoParams, completion: @escaping (Result<Data, FailureInfo>) -> ())
    func delete(id: String, completion: @escaping (Result<Data, FailureInfo>) -> ())
}
