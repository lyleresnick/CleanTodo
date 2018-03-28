//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoManagerTestImpl: TodoManager {

    func all(completion: @escaping (TodoListManagerResponse) -> ()) {
        completion(.success(entity: todoTestData))
    }
    
    func fetch(id:String, completion: @escaping (TodoItemManagerResponse) -> ()) {
        for entity in todoTestData {
            if entity.id == id {
                
                completion(.success(entity: entity))
                return
            }
        }
        completion(.semanticError(reason: .notFound))
    }
    
    func completed(id:String, completed: Bool, completion: @escaping (TodoItemManagerResponse) -> ()) {
        
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
            completion: @escaping (TodoItemManagerResponse) -> ()) {
        
        let todo = Todo( id: UUID().uuidString, values: values)
        todoTestData.append(todo)
        completion(.success(entity: todo))
    }

    func update(
            id: String,
            values: TodoValues,
            completion: @escaping (TodoItemManagerResponse) -> ()) {
        
        if let todo = findTodo(id: id) {
            
            todo.set(values: values)
            completion(.success(entity: todo))
        }
        else {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    private func findTodo(id: String) -> Todo? {
        for entity in todoTestData {
            if entity.id == id {
                return entity
            }
        }
        return nil
    }

    func delete(id: String, completion: @escaping (TodoItemManagerResponse) -> ()) {
        
        if let (index, todo) = findTodoIndex(id: id) {
            
            todoTestData.remove(at: index)
            completion(.success(entity: todo))
        }
        else {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    private func findTodoIndex(id: String) -> (Int,Todo)? {
        for (index, entity) in todoTestData.enumerated() {
            if entity.id == id {
                return (index, entity)
            }
        }
        return nil
    }
}

private extension Todo {
    
    func set(values: TodoValues) {
        
        title = values.title
        note = values.note
        completeBy = values.completeBy
        priority = values.priority
        completed = values.completed
    }
}
