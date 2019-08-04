//  Copyright © 2018 Lyle Resnick. All rights reserved.

import Foundation
import CoreData

public class CoreDataTodo: NSManagedObject {
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var completeBy: Date?
    @NSManaged public var priority: String?
    @NSManaged public var completed: Bool
}
