
//  Copyright © 2018 Lyle Resnick. All rights reserved.

import Foundation

extension Todo {
    
    convenience init(todoCoreData: TodoCoreData) {
        
        guard let id = todoCoreData.id else {
            fatalError("Missing id")
        }
        let title = todoCoreData.title!
        let note = todoCoreData.note!
        let completeBy = todoCoreData.completeBy
        let priority = todoCoreData.priority
        let completed = todoCoreData.completed
        
        self.init(
            id: id.uuidString,
            title: title,
            note: note,
            completeBy: completeBy,
            priority: (priority != nil) ? Priority(rawValue: priority!)! : nil,
            completed: completed )
    }
}
