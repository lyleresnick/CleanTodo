//  Copyright © 2020 Lyle Resnick. All rights reserved.

import Foundation

extension Todo {
    
    init(networkedTodo from: NetworkedTodo) throws {
        guard let id = from.id
        else {
            throw FormatException(description: "id must not be null")
        }
        try self.init(
            id: id,
            title: from.title,
            note: from.note,
            completeBy: from.completeBy,
            priority: from.priority,
            completed: from.completed)
    }
}
