//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation
import CoreData

class CoreDataTodoManager: TodoManager {
    
    let manager: CoreDataManager
    init(manager: CoreDataManager) {
        self.manager = manager
    }
    
    private func fetchRequest(id: String) -> NSFetchRequest<CoreDataTodo> {
        
        let fetchRequest = NSFetchRequest<CoreDataTodo>(entityName: "Todo")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        return fetchRequest
    }

    private lazy var fetchRequestAll =  NSFetchRequest<CoreDataTodo>(entityName: "Todo")
    func all(completion: @escaping (Response<[Todo], Void>) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in

            do {
                let coreDataTodoList = try context.fetch(self.fetchRequestAll)
                let dirtyTodoList = coreDataTodoList.map { Todo(coreDataTodo: $0) }
                let todoList = dirtyTodoList.compactMap { $0 }
                guard dirtyTodoList.count == todoList.count else {
                    completion(.failure(description: "invalid Todo data"))
                    return
                }
                completion(.success(entity: todoList ))
            } catch {
                let nserror = error as NSError
                completion(.failure(description: nserror.localizedDescription))
            }
        }
    }
    
    private func makeItemFailure<Entity, DomainIssue>(error: Error) -> Response<Entity, DomainIssue> {
        let nserror = error as NSError
        return .failure(description: nserror.localizedDescription)
    }
    
    func fetch(id: String, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {

        manager.persistentContainer.performBackgroundTask() { context in

            do {
                let coreDataTodoList = try context.fetch(self.fetchRequest(id: id))
                if coreDataTodoList.count > 0, let coreDataTodo = coreDataTodoList.first {
                    completion(self.makeTodo(coreDataTodo: coreDataTodo))
                }
                else {
                    completion(.domain(issue: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func completed(id: String, completed: Bool, completion: @escaping (Response<Todo, ItemIssue>) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in
            
            do {
                let coreDataTodoList = try context.fetch(self.fetchRequest(id: id))
                if coreDataTodoList.count > 0, let coreDataTodo = coreDataTodoList.first {
                    coreDataTodo.completed = completed
                    try context.save()
                    completion(self.makeTodo(coreDataTodo: coreDataTodo))
                }
                else {
                    completion(.domain(issue: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func create(
            values: TodoValues,
            completion: @escaping (Response<Todo, Void>) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in
            
            let coreDataTodo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! CoreDataTodo
            
            coreDataTodo.id = UUID()
            coreDataTodo.set(values: values)
            do {
                try context.save()
                completion(self.makeTodo(coreDataTodo: coreDataTodo))
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func makeTodo(coreDataTodo: CoreDataTodo) -> Response<Todo, ItemIssue> {
        guard let todo = Todo(coreDataTodo: coreDataTodo) else {
            return .failure(description: "invalid Todo data")
        }
        return .success(entity: todo)
    }

    func makeTodo(coreDataTodo: CoreDataTodo) -> Response<Todo, Void> {
        guard let todo = Todo(coreDataTodo: coreDataTodo) else {
            return .failure(description: "invalid Todo data")
        }
        return .success(entity: todo)
    }

    func update(
            id: String,
            values: TodoValues,
            completion: @escaping (Response<Todo, ItemIssue>) -> ()) {

        manager.persistentContainer.performBackgroundTask() { context in
            
            do {
                let coreDataTodoList = try context.fetch(self.fetchRequest(id: id))
                if coreDataTodoList.count > 0, let coreDataTodo = coreDataTodoList.first {
                    coreDataTodo.set(values: values)

                    try context.save()
                    completion(self.makeTodo(coreDataTodo: coreDataTodo))
                }
                else {
                    completion(.domain(issue: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func delete(id: String, completion: @escaping (Response<Todo?, DeleteIssue>) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in
            
            do {
                let coreDataTodoList = try context.fetch(self.fetchRequest(id: id))
                if coreDataTodoList.count > 0, let coreDataTodo = coreDataTodoList.first {
                    context.delete(coreDataTodo)
                    try context.save()
                    completion(.success(entity: nil))
                }
                else {
                    completion(.domain(issue: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
}

private extension CoreDataTodo {
    
    func set(values: TodoValues) {
        title = values.title
        note = values.note
        priority = values.priority.rawValue
        completeBy = values.completeBy
        completed = values.completed
    }
}

private extension Todo {
    
    init?(coreDataTodo: CoreDataTodo) {
        
        guard let id = coreDataTodo.id,
            let title = coreDataTodo.title,
            let note = coreDataTodo.note,
            let rawPriority = coreDataTodo.priority,
            let priority = Priority(rawValue: rawPriority) else {
                return nil
        }
        
        self.init(
            id: id.uuidString,
            title: title,
            note: note,
            completeBy: coreDataTodo.completeBy,
            priority: priority,
            completed: coreDataTodo.completed )
    }
}
