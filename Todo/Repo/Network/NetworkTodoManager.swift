//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

class NetworkTodoManager: TodoManager {
    
    private let apiClient: ApiClient
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    private let formatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd'T23:59:59Z'")
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()

    func all(completion: @escaping (Response<[Todo], Void>) -> ()) {
        apiClient.all { [weak self] result in
            guard let self = self else { return }
            completion( self.exceptionGuard(result: result) { data in
                let networkedTodoList = try self.decoder.decode([NetworkedTodo].self, from: data)
                return try networkedTodoList.compactMap {
                    try Todo(networkedTodo: $0)
                }
            })
        }
    }
    
    func fetch(id: String, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        apiClient.fetch(id: id) {  [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            } domainFilter: { failureInfo in
                if failureInfo.statusCode == 404 {
                    return .notFound
                }
                return nil
            })
        }
    }
    
    func completed(id:String, completed: Bool, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        
        func myCompletion(_ response: Response<Todo, ItemIssue>) {
            switch response {
            case let .success(todo):
                let todoValues = TodoValues(title: todo.title, note: todo.note, completeBy: todo.completeBy, priority: todo.priority, completed: completed)
                update(id: id, values: todoValues, completion: completion)
            case .failure:
                completion(response)
            case .domain:
                completion(response)
            }
        }
        
        apiClient.fetch(id: id) { [weak self] result in
            guard let self = self else { return }
            myCompletion(self.exceptionGuard(result: result) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            } domainFilter: { failureInfo in
                if failureInfo.statusCode == 404 {
                    return .notFound
                }
                return nil
            })
        }
    }
    
    func create(values: TodoValues, completion: @escaping (Response<Todo, Void>) -> ()) {
        apiClient.create(values: values) { [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            })
        }
    }
    
    func update(id: String, values: TodoValues, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        apiClient.update(id: id, values: values) { [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            } domainFilter: { failureInfo in
                if failureInfo.statusCode == 404 {
                    return .notFound
                }
                return nil
            })
        }
    }

    func delete(id: String, completion: @escaping (Response<Todo?, DeleteIssue>) -> ()) {
        apiClient.delete(id: id) { [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                return nil
            } domainFilter: { failureInfo in
                switch failureInfo.statusCode {
                case 404:
                    return .notFound
                case 204:
                    return .noData
                default:
                    return nil
                }
            })
        }
    }
    
    func exceptionGuard<Entity, DomainIssue>(result: Result<Data, FailureInfo>,
              process: @escaping ((Data) throws -> Entity),
              domainFilter: ((FailureInfo) -> DomainIssue?)? = nil) -> Response<Entity, DomainIssue> {
        do {
            switch result {
            case let .success(data):
                let entity = try process(data)
                return .success(entity: entity)
            case let .failure(failureInfo):
                //          if( error.statusCode == "network-request-failed")
                //            return .networkIssue(NetworkIssue.noNetwork);
                if let domainFilter = domainFilter, let issue = domainFilter(failureInfo) {
                    return .domain(issue: issue);
                }
                return .failure(description: "\(failureInfo.statusCode == nil ? "iOS Error" : String(failureInfo.statusCode!))  \(failureInfo.description)");
            }
        } catch let error {
            return .failure(description: error.localizedDescription);
        }
          
    }
}
