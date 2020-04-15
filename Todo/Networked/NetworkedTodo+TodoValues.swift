//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

extension NetworkedTodo {
    
    init(todoValues from: TodoValues) {
        self.init(
            id: nil,
            title: from.title,
            note: from.note,
            completeBy: from.completeBy,
            priority: from.priority.rawValue,
            completed: from.completed)
    }
}
