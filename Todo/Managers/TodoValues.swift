//  Copyright © 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoValues {
    
    var title: String
    var note: String
    var completeBy: Date?
    var priority: Todo.Priority?
    var completed: Bool
}

extension Todo {
    
    convenience init(id: String, values: TodoValues) {
        
        self.init(
            id: id,
            title: values.title,
            note: values.note,
            completeBy: values.completeBy,
            priority: values.priority,
            completed: values.completed)
    }
}
