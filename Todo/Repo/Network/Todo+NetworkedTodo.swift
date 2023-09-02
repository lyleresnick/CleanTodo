//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

extension Todo {
    
    init(todoResponse from: TodoResponse) throws {
        try self.init(
            id: from.id,
            title: from.title,
            note: from.note ,
            completeBy: from.completeBy,
            priority: from.priority,
            completed: from.completed)
    }
}
