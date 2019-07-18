//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

enum  TodoErrorReason: Error {
    case notFound
}

enum DataSources {
    case test
    case coreData
}

typealias TodoListManagerResponse = ManagerResponse<[Todo], DataSources, TodoErrorReason>
typealias TodoItemManagerResponse = ManagerResponse<Todo, DataSources, TodoErrorReason>

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



