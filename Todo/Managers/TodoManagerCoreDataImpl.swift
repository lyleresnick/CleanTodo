//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoManagerCoreDataImpl: TodoManager {
    
    let manager: CoreDataManager
    init(manager: CoreDataManager) {
        self.manager = manager
    }

    func all(completion: (ManagerResponse<[Todo], TodoErrorReason>) -> ()) {
        completion(.success(entity: todoData))
    }
    
    func fetch(id:String, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ()) {
        for entity in todoData {
            if entity.id == id {
                
                completion(.success(entity: entity))
                return
            }
        }
        completion(.semanticError(reason: .notFound))
    }
    
    func completed(id:String, completed: Bool, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ()) {
        
        if let todo = findTodo(id: id) {
            
            todo.completed = completed
            completion(.success(entity: todo))
        }
        else {
            completion(.semanticError(reason: .notFound))

        }
    }
    
    func create(
            values: TodoValues,
            completion: (ManagerResponse<Todo, TodoErrorReason>) -> ()) {
        
        let todo = Todo( id: UUID().uuidString, values: values)
        todoData.append(todo)
        completion(.success(entity: todo))
    }

    func update(
            id: String,
            values: TodoValues,
            completion: (ManagerResponse<Todo, TodoErrorReason>) -> ()) {
        
        if let todo = findTodo(id: id) {
            
            todo.set(values: values)
            completion(.success(entity: todo))
        }
        else {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    private func findTodo(id: String) -> Todo? {
        for entity in todoData {
            if entity.id == id {
                return entity
            }
        }
        return nil
    }

    func delete(id:String, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ()) {
        
        if let (index, todo) = findTodoIndex(id: id) {
            
            todoData.remove(at: index)
            completion(.success(entity: todo))
        }
        else {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    private func findTodoIndex(id: String) -> (Int,Todo)? {
        for (index, entity) in todoData.enumerated() {
            if entity.id == id {
                return (index, entity)
            }
        }
        return nil
    }
}

private extension Todo {
    
    convenience init(id: String, values: TodoValues) {
        
        self.init(
            id: id,
            title: values.title,
            note: values.note,
            completeBy: values.completeBy,
            priority: values.priority,
            completed: values.completed)
    }
    
    func set(values: TodoValues) {
        
        title = values.title
        note = values.note
        completeBy = values.completeBy
        priority = values.priority
        completed = values.completed
    }
}
