//  Copyright © 2019 Lyle Resnick. All rights reserved.

import Foundation

class EphemeralTodo {

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

extension EphemeralTodo {
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

extension EphemeralTodo {
    
    private static let inboundDateFormatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd")
    
    convenience init(dictionary: [String:String]) {
        
        guard let id = dictionary["id"] else {
            fatalError("Missing id")
        }
        let title = dictionary["title"]!
        let note = dictionary["note"]!
        let completeBy = dictionary["completeBy"]
        let priority = dictionary["priority"] ?? "none"
        let completed = dictionary["completed"]!
        
        self.init(
            id: id,
            title: title,
            note: note,
            completeBy: (completeBy != nil) ? EphemeralTodo.convert(date: completeBy!) : nil,
            priority: Priority(rawValue: priority)!,
            completed: (completed == "true") )
    }
    
    private static func convert(date: String) -> Date {
        guard let date = EphemeralTodo.inboundDateFormatter.date( from: date ) else {
            fatalError("Format of date is incorrect")
        }
        return date
    }
}

