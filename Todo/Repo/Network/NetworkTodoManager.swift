//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

class NetworkTodoManager: TodoManager {
    
    private let apiClient: ApiClient
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    func all(completion: @escaping (Response<[Todo], Void>) -> ()) {
        apiClient.all { [weak self] result in
            guard let self = self else { return }
            completion( self.exceptionGuard(result: result) { data in
                let responseTodoList = try self.decoder.decode([TodoResponse].self, from: data)
                return try responseTodoList.compactMap {
                    try Todo(todoResponse: $0)
                }
            })
        }
    }
    
    func fetch(id: String, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        apiClient.fetch(id: id) {  [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                let TodoResponse = try self.decoder.decode(TodoResponse.self, from: data)
                return try Todo(todoResponse: TodoResponse)
            } domainFilter: { code in
                if code == 404 {
                    return .notFound
                }
                return nil
            })
        }
    }
    
    func completed(id:String, completed: Bool, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        
        func fetchCompletion(_ response: Response<Todo, ItemIssue>) {
            switch response {
            case let .success(todo):
                let todoValues = TodoValues(title: todo.title, note: todo.note, completeBy: todo.completeBy, priority: todo.priority, completed: completed)
                update(id: id, values: todoValues, completion: completion)
            default:
                completion(response)
            }
        }
        
        apiClient.fetch(id: id) { [weak self] result in
            guard let self = self else { return }
            fetchCompletion(self.exceptionGuard(result: result) { data in
                let todoResponse = try self.decoder.decode(TodoResponse.self, from: data)
                return try Todo(todoResponse: todoResponse)
            } domainFilter: { code in
                if code == 404 {
                    return .notFound
                }
                return nil
            })
        }
    }
    
    func create(values: TodoValues, completion: @escaping (Response<Todo, Void>) -> ()) {
        apiClient.create(params: TodoParams(values: values)) { [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                let todoResponse = try self.decoder.decode(TodoResponse.self, from: data)
                return try Todo(todoResponse: todoResponse)
            })
        }
    }
    
    func update(id: String, values: TodoValues, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        apiClient.update(id: id, params: TodoParams(values: values)) { [weak self] result in
            guard let self = self else { return }
            completion(self.exceptionGuard(result: result) { data in
                let todoResponse = try self.decoder.decode(TodoResponse.self, from: data)
                return try Todo(todoResponse: todoResponse)
            } domainFilter: { code in
                if code == 404 {
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
            } domainFilter: { code in
                switch code {
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
              domainFilter: ((Int) -> DomainIssue?)? = nil) -> Response<Entity, DomainIssue> {
        do {
            switch result {
            case let .success(data):
                let entity = try process(data)
                return .success(entity: entity)
            case let .failure(failureInfo):
                switch failureInfo.party {
                case let .client(code):
                    switch code {
                    case -1009:
                        return .networkIssue(issue: NetworkIssue.noNetwork)
                    default:
                        return .failure(description: "Code: \(code ?? 0), \(failureInfo.description)");
                    }
                case let .server(code):
                    if let domainFilter = domainFilter, let issue = domainFilter(code) {
                        return .domain(issue: issue);
                    }
                    return .failure(description: "Code: \(code), \(failureInfo.description)");
                }
            }
        } catch let error {
            return .failure(description: error.localizedDescription);
        }
    }
}
