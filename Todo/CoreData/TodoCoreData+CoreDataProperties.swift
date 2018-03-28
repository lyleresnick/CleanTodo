//
//  TodoCoreData+CoreDataProperties.swift
//  Todo
//
//  Created by Lyle Resnick on 2018-03-20.
//  Copyright © 2018 Lyle Resnick. All rights reserved.
//
//

import Foundation
import CoreData


extension TodoCoreData {

    @NSManaged public var completeBy: Date?
    @NSManaged public var completed: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?
    @NSManaged public var priority: String?
    @NSManaged public var title: String?

}
