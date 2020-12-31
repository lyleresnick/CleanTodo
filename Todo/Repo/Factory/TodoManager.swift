//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

enum  TodoSemanticEvent: Error {
    case notFound
    case noData
}

enum DataSources {
    case test
    case coreData
    case networked
}

typealias TodoListManagerResponse = ManagerResponse<[Todo], DataSources, TodoSemanticEvent>
typealias TodoItemManagerResponse = ManagerResponse<Todo, DataSources, TodoSemanticEvent>

protocol TodoManager {
    
    func all(completion: @escaping (TodoListManagerResponse) -> ())
    func completed(id: String, completed: Bool, completion: @escaping (TodoItemManagerResponse) -> ())
    
    func create(
                values: TodoValues,
                completion: @escaping (TodoItemManagerResponse) -> ())
    
    func update(id: String,
                values: TodoValues,
                completion: @escaping (TodoItemManagerResponse) -> ())
    
    func fetch(id:String, completion: @escaping (TodoItemManagerResponse) -> ())
    
    func delete(id:String, completion: @escaping (TodoItemManagerResponse) -> ())
}



