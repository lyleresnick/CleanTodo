//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation
import CoreData

class TodoManagerCoreDataImpl: TodoManager {
    
    let manager: CoreDataManager
    init(manager: CoreDataManager) {
        self.manager = manager
    }
    
    private let fetchRequest =  NSFetchRequest<TodoCoreData>(entityName: "Todo")

    func all(completion: (TodoListManagerResponse) -> ()) {
        
        do {
            let todos = try manager.persistentContainer.viewContext.fetch(fetchRequest)
            let todoData = todos.map { Todo(todoCoreData: $0) }
            completion(.success(entity: todoData))

        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }

        
    }
    
    func fetch(id: String, completion: (TodoItemManagerResponse) -> ()) {
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            
            let todos = try manager.persistentContainer.viewContext.fetch(fetchRequest)
            let todoData = todos.map { Todo(todoCoreData: $0) }
            completion(.success(entity: todoData.first!))
        }
        catch {
            
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func completed(id: String, completed: Bool, completion: (TodoItemManagerResponse) -> ()) {
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            
            let todoCoreDataList = try manager.persistentContainer.viewContext.fetch(fetchRequest)
            let todoCoreData = todoCoreDataList.first!
            
            todoCoreData.completed = completed

            try manager.save()
            completion(.success(entity: Todo(todoCoreData: todoCoreData) ) )
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func create(
            values: TodoValues,
            completion: (TodoItemManagerResponse) -> ()) {
        
        let todoCoreData = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: manager.persistentContainer.viewContext) as! TodoCoreData
        
        let id = UUID()

        todoCoreData.id = id
        assignValues(todoCoreData: todoCoreData, todoValues: values)
        do {
            try manager.save()
            completion(.success(entity: Todo(id: id.uuidString, values: values) ) )
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    private func assignValues(todoCoreData: TodoCoreData, todoValues: TodoValues) {
        
        todoCoreData.title = todoValues.title
        todoCoreData.note = todoValues.note
        todoCoreData.priority = (todoValues.priority != nil) ? todoValues.priority!.rawValue : nil
        todoCoreData.completeBy = todoValues.completeBy
        todoCoreData.completed = todoValues.completed
    }

    func update(
            id: String,
            values: TodoValues,
            completion: (TodoItemManagerResponse) -> ()) {

        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            
            let todoCoreDataList = try manager.persistentContainer.viewContext.fetch(fetchRequest)
            let todoCoreData = todoCoreDataList.first!
            
            assignValues(todoCoreData: todoCoreData, todoValues: values)
            try manager.save()
            completion(.success(entity: Todo(id: id, values: values) ) )
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func delete(id: String, completion: (TodoItemManagerResponse) -> ()) {
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            
            let todoCoreDataList = try manager.persistentContainer.viewContext.fetch(fetchRequest)
            let todoCoreData = todoCoreDataList.first!
            
            let todo = Todo(todoCoreData: todoCoreData)
            manager.persistentContainer.viewContext.delete(todoCoreData)
            try manager.save()
            completion(.success(entity: todo) )
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
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
