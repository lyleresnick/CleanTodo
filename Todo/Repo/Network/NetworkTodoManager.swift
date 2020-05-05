//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

struct NetworkCodeError : Error {
    let statusCode: Int
    let description: String
    
    init(statusCode: Int, description: String) {
        self.statusCode = statusCode
        self.description = description
    }
    
    init(response: HTTPURLResponse) {
        self.init(statusCode: response.statusCode, description: "Networking Error \(response.statusCode) \(response.description)")
    }
}

struct NetworkError : Error {
    let description: String
}


class NetworkTodoManager: TodoManager {
    
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

    static private let todobackendUrl = "https://todobackend-lyle.herokuapp.com/api"
//    static private let todobackendUrl = "http://localhost:8080/api"
    private let baseURL = URL(string: todobackendUrl)!
    
    private let formatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd'T23:59:59Z'")
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
    private lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .formatted(formatter)
        return encoder
    }()
    
    func all(completion: @escaping (Response<[Todo], Void>) -> ()) {
        let url = baseURL.appendingPathComponent("todo")
        let dataTask = session.dataTask(with: url) { data, response, error in

            completion( self.exceptionGuard(data: data, response: response, error: error) { data in
                    let networkedTodoList = try self.decoder.decode([NetworkedTodo].self, from: data)
                    return try networkedTodoList.compactMap {
                        try Todo(networkedTodo: $0)
                    }
                })
            }

        dataTask.resume()
    }
    
    func fetch(id: String, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        
        let dataTask = session.dataTask(with: makeRequest(httpMethod: .get, resource: makeResource(id: id))) { data, response, error in
            completion(self.exceptionGuard(data: data, response: response, error: error) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            } domainFilter: { networkError in
                if networkError.statusCode == 404 {
                    return .notFound
                }
                return nil
            })
        }
        dataTask.resume()
    }
    
    private func makeRequest(httpMethod: HTTPMethod, resource: String) -> URLRequest {
        let url = baseURL.appendingPathComponent(resource)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        return request
    }
    
    private func makeUploadRequest(httpMethod: HTTPMethod, resource: String) -> URLRequest {
        var request = makeRequest(httpMethod: httpMethod, resource: resource)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
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
        
        let dataTask = session.dataTask(with: makeRequest(httpMethod: .get, resource: makeResource(id: id))) { data, response, error in
            myCompletion(self.exceptionGuard(data: data, response: response, error: error) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            } domainFilter: { networkError in
                if networkError.statusCode == 404 {
                    return .notFound
                }
                return nil
            })
        }
        dataTask.resume()
    }
    
    private func makeResource(id: String) -> String {
       return "todo/\(id)"
    }
    
    func create(
            values: TodoValues,
            completion: @escaping (Response<Todo, Void>) -> ()) {
                
        let request = makeUploadRequest(httpMethod: .post, resource: "todo")
        let jsonData: Data
        do {
            jsonData = try encoder.encode(NetworkedTodo(todoValues: values))
        }
        catch {
            return completion(.failure(source: .networked, description: error.localizedDescription))
        }

        let uploadTask = session.uploadTask(with: request, from: jsonData) { data, response, error in
            completion(self.exceptionGuard(data: data, response: response, error: error) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            })
        }
        uploadTask.resume()

    }
    
    func update(
            id: String,
            values: TodoValues,
            completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        let request = makeUploadRequest(httpMethod: .put, resource: makeResource(id: id))
        let jsonData: Data
        do {
            jsonData = try encoder.encode(NetworkedTodo(todoValues: values))
        }
        catch {
            return completion(.failure(source: .networked, description: error.localizedDescription))
        }

        let uploadTask = session.uploadTask(with: request, from: jsonData) { data, response, error in
            completion(self.exceptionGuard(data: data, response: response, error: error) { data in
                let networkedTodo = try self.decoder.decode(NetworkedTodo.self, from: data)
                return try Todo(networkedTodo: networkedTodo)
            } domainFilter: { networkError in
                if networkError.statusCode == 404 {
                    return .notFound
                }
                return nil
            })
       }
       uploadTask.resume()
    }
    
    func delete(id: String, completion: @escaping (Response<Todo?, DeleteIssue>) -> ()) {
                    
        let dataTask = session.dataTask(with: makeRequest(httpMethod: .delete, resource: makeResource(id: id))) { data, response, error in
            completion(self.exceptionGuard(data: data, response: response, error: error) { data in
                return nil
            } domainFilter: { networkError in
                switch networkError.statusCode {
                case 404:
                    return .notFound
                case 204:
                    return .noData
                default:
                    return nil
                }
            })
        }
        dataTask.resume()
    }
    
    func exceptionGuard<Entity, DomainIssue>( data: Data?, response: URLResponse?, error: Error?,
              process: @escaping ((Data) throws -> Entity),
              domainFilter: ((NetworkCodeError) -> DomainIssue?)? = nil) -> Response<Entity, DomainIssue> {
        do {
            if let error = error {
                throw NetworkError(description: error.localizedDescription)
            }
            guard let data = data else {
                throw NetworkError(description: "Data is nil")
            }
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError(description: "response is not a HTTPURLResponse")
            }
            guard response.statusCode == 200 else { throw NetworkCodeError(response: response) }

            let result = try process(data);
            return .success(entity: result);
        } catch let error as NetworkCodeError {
            //          if( error.statusCode == "network-request-failed")
            //            return .networkIssue(NetworkIssue.noNetwork);
            if let domainFilter = domainFilter, let issue = domainFilter(error) {
                return .domain(issue: issue);
            }
            return .failure(source: .networked, description: "\(error.statusCode)  \(error.description)");
        } catch let error {
            return .failure(source: .networked, description: error.localizedDescription);
        }
          
    }
}


private struct DomainIssueException<DomainIssue> {
    let domainIssue: DomainIssue
}

