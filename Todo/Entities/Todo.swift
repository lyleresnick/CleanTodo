//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct Todo {
    
    let id: String
    let title: String
    let note: String
    let completeBy: Date?
    let priority: Priority
    let completed: Bool
    
    init( id: String, title: String, note: String = "", completeBy: Date? = nil, priority: Priority = .none, completed: Bool = false) {
        self.id = id
        self.title = title
        self.note = note
        self.completeBy = completeBy
        self.priority = priority
        self.completed = completed
    }
}


