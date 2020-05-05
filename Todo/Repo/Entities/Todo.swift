//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct FormatException : Error {
    let description: String
}

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
    
    init( id: String, title: String, note: String = "", completeBy: Date? = nil, priority rawPriority: String, completed: Bool = false) throws {
        guard
            let priority = Priority(rawValue: rawPriority)
        else {
            throw(FormatException(description: "Todo intialized found with invalid priority: \(rawPriority)"))
        }
        self.id = id
        self.title = title
        self.note = note
        self.completeBy = completeBy
        self.priority = priority
        self.completed = completed
    }

}
