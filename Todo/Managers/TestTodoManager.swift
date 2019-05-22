//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TestTodoManager: TodoManager {

    func all(completion: @escaping (TodoListManagerResponse) -> ()) {
        completion(.success(entity: todoTestData))
    }
    
    func fetch(id:String, completion: @escaping (TodoItemManagerResponse) -> ()) {
        do {
            let todo = try findTodo(id: id)
            completion(.success(entity: todo))
        }
        catch {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    func completed(id:String, completed: Bool, completion: @escaping (TodoItemManagerResponse) -> ()) {
        do {
            let todo = try findTodo(id: id)
            todo.completed = completed
            completion(.success(entity: todo))
        }
        catch {
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
        
        do {
            let todo = try findTodo(id: id)
            todo.set(values: values)
            completion(.success(entity: todo))
        }
        catch {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    func delete(id: String, completion: @escaping (TodoItemManagerResponse) -> ()) {
        
        do {
            let (index, todo) = try findTodoIndex(id: id)
            todoTestData.remove(at: index)
            completion(.success(entity: todo))
        }
        catch {
            completion(.semanticError(reason: .notFound))
        }
    }
    
    private func findTodo(id: String) throws -> Todo {
        for entity in todoTestData {
            if entity.id == id {
                return entity
            }
        }
        throw TodoErrorReason.notFound
    }
    
    private func findTodoIndex(id: String) throws -> (Int,Todo) {
        for (index, entity) in todoTestData.enumerated() {
            if entity.id == id {
                return (index, entity)
            }
        }
        throw TodoErrorReason.notFound
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
