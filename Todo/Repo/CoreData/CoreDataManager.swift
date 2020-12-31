//  Copyright © 2018 Lyle Resnick. All rights reserved.

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Todo")
        container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveAll() {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertNewObject(entityName: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: persistentContainer.viewContext)
    }
    
    func delete(object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
    }
    
    func fetch<T>(fetchRequest: NSFetchRequest<T>) throws -> [T]  {
        return try persistentContainer.viewContext.fetch(fetchRequest)
    }
    
    func save() throws {
        
        try persistentContainer.viewContext.save()
    }


}


