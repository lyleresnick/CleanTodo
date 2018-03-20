//
//  TodoCoreData+CoreDataProperties.swift
//  Todo
//
//  Created by Lyle Resnick on 2018-03-19.
//  Copyright © 2018 Lyle Resnick. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoCoreData> {
        return NSFetchRequest<TodoCoreData>(entityName: "Todo")
    }

    @NSManaged public var completeBy: NSDate?
    @NSManaged public var completed: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?
    @NSManaged public var priorityName: String?
    @NSManaged public var title: String?

}
