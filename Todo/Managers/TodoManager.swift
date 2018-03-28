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
    
    func all(completion: @escaping (TodoListManagerResponse) -> ())
    func completed(id: String, completed: Bool, completion:  @escaping (TodoItemManagerResponse) -> ())
    
    func create(
                values: TodoValues,
                completion:  @escaping (TodoItemManagerResponse) -> ())
    
    func update(id: String,
                values: TodoValues,
                completion:  @escaping (TodoItemManagerResponse) -> ())
    
    func fetch(id:String, completion:  @escaping (TodoItemManagerResponse) -> ())
    
    func delete(id:String, completion:  @escaping (TodoItemManagerResponse) -> ())
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


