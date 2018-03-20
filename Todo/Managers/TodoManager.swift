//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

enum  TodoErrorReason {
    case notFound
}

struct TodoValues {
    
    var title: String
    var note: String
    var completeBy: Date?
    var priority: Todo.Priority?
    var completed: Bool
}

protocol TodoManager {
    
    func all(completion: (ManagerResponse<[Todo], TodoErrorReason>) -> ())
    func completed(id: String, completed: Bool, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ())
    
    func create(
                values: TodoValues,
                completion: (ManagerResponse<Todo, TodoErrorReason>) -> ())
    
    func update(id: String,
                values: TodoValues,
                completion: (ManagerResponse<Todo, TodoErrorReason>) -> ())
    
    func fetch(id:String, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ())
    
    func delete(id:String, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ())
}
