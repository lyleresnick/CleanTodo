//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation
import CoreData

class TodoManagerCoreDataImpl: TodoManager {
    
    let manager: CoreDataManager
    init(manager: CoreDataManager) {
        self.manager = manager
    }
    
    private let fetchRequestAll =  NSFetchRequest<TodoCoreData>(entityName: "Todo")
    
    private func fetchRequest(id: String) -> NSFetchRequest<TodoCoreData> {
        
        let fetchRequest = NSFetchRequest<TodoCoreData>(entityName: "Todo")
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        return fetchRequest
    }

    func all(completion: @escaping (TodoListManagerResponse) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in

            do {
                let todoCoreDataList = try context.fetch(self.fetchRequestAll)
                let todoList = todoCoreDataList.map { Todo(todoCoreData: $0) }
                completion(.success(entity: todoList))

            } catch {
                let nserror = error as NSError
                completion(.failure(source: .coreData, code: nserror.code, description: nserror.localizedDescription))
            }
        }
    }
    
    private func makeItemFailure(error: Error) -> TodoItemManagerResponse {
        let nserror = error as NSError
        return .failure(source: .coreData, code: nserror.code, description: nserror.localizedDescription)
    }
    
    func fetch(id: String, completion:  @escaping (TodoItemManagerResponse) -> ()) {

        manager.persistentContainer.performBackgroundTask() { context in

            do {
                let todoCoreDataList = try context.fetch(self.fetchRequest(id: id))
                if todoCoreDataList.count > 0 {

                    let todoList = todoCoreDataList.map { Todo(todoCoreData: $0) }
                    completion(.success(entity: todoList.first!))
                }
                else {
                    completion(.semanticError(reason: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func completed(id: String, completed: Bool, completion: @escaping (TodoItemManagerResponse) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in
            
            do {
                let todoCoreDataList = try context.fetch(self.fetchRequest(id: id))
                if todoCoreDataList.count > 0 {
                    
                    let todoCoreData = todoCoreDataList.first!
                    todoCoreData.completed = completed

                    try context.save()
                    completion(.success(entity: Todo(todoCoreData: todoCoreData) ) )
                }
                else {
                    completion(.semanticError(reason: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func create(
            values: TodoValues,
            completion:  @escaping (TodoItemManagerResponse) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in
            
            let todoCoreData = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context) as! TodoCoreData
            
            let id = UUID()

            todoCoreData.id = id
            todoCoreData.set(values: values)
            do {
                try context.save()
                completion(.success(entity: Todo(id: id.uuidString, values: values) ) )
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func update(
            id: String,
            values: TodoValues,
            completion:  @escaping (TodoItemManagerResponse) -> ()) {

        manager.persistentContainer.performBackgroundTask() { context in
            
            do {
                let todoCoreDataList = try context.fetch(self.fetchRequest(id: id))
                if todoCoreDataList.count > 0 {
                    
                    let todoCoreData = todoCoreDataList.first!
                    todoCoreData.set(values: values)

                    try context.save()
                    completion(.success(entity: Todo(id: id, values: values) ) )
                }
                else {
                    completion(.semanticError(reason: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
    
    func delete(id: String, completion:  @escaping (TodoItemManagerResponse) -> ()) {
        
        manager.persistentContainer.performBackgroundTask() { context in
            
            do {
                let todoCoreDataList = try context.fetch(self.fetchRequest(id: id))
                if todoCoreDataList.count > 0 {
                    
                    let todoCoreData = todoCoreDataList.first!
                    let todo = Todo(todoCoreData: todoCoreData)
                    context.delete(todoCoreData)
                    try context.save()
                    completion(.success(entity: todo) )
                }
                else {
                    completion(.semanticError(reason: .notFound))
                }
            }
            catch {
                completion(self.makeItemFailure(error: error))
            }
        }
    }
}

private extension TodoCoreData {
    
    func set(values: TodoValues) {
        
        title = values.title
        note = values.note
        priority = (values.priority != nil) ? values.priority!.rawValue : nil
        completeBy = values.completeBy
        completed = values.completed
    }
}

