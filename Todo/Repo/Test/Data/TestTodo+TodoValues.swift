//  Copyright © 2019 Lyle Resnick. All rights reserved.

import Foundation

extension TestTodo {
    
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
