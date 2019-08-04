//  Copyright © 2019 Lyle Resnick. All rights reserved.

import Foundation

class TestTodo {

    var id: String
    var title: String
    var note: String
    var completeBy: Date?
    var priority: Priority
    var completed: Bool
    
    init( id: String, title: String, note: String = "", completeBy: Date? = nil, priority: Priority = .none, completed: Bool = false) {
        self.id = id
        self.title = title
        self.note = note
        self.completeBy = completeBy
        self.priority = priority
        self.completed = completed
    }
}

