//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoListPresentationModel {
    
    let id: String
    let title: String
    let notes: String
    let date: Date?
    let priority: Todo.Priority?
    let done: Bool
    
    init(entity: Todo) {
        self.id = entity.id
        self.title = entity.title
        self.notes = entity.notes
        self.date = entity.date
        self.priority = entity.priority
        self.done = entity.done
    }
}
