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

typealias TodoListManagerResponse = ManagerResponse<[Todo], DataSources, TodoErrorReason>
typealias TodoItemManagerResponse = ManagerResponse<Todo, DataSources, TodoErrorReason>

protocol TodoManager {
    
    func all(completion: (TodoListManagerResponse) -> ())
    func completed(id: String, completed: Bool, completion: (TodoItemManagerResponse) -> ())
    
    func create(
                values: TodoValues,
                completion: (TodoItemManagerResponse) -> ())
    
    func update(id: String,
                values: TodoValues,
                completion: (TodoItemManagerResponse) -> ())
    
    func fetch(id:String, completion: (TodoItemManagerResponse) -> ())
    
    func delete(id:String, completion: (TodoItemManagerResponse) -> ())
}

extension Todo {
    
    convenience init(id: String, values: TodoValues) {
        
        self.init(
            id: id,
            title: values.title,
            note: values.note,
            completeBy: values.completeBy,
            priority: values.priority,
            completed: values.completed)
    }
}


