//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class Todo {
    
    enum Priority: String {
        case high
        case medium
        case low
        
        
        var bangs: Int {
            guard case self = self else { return 0 }
            
            switch self {
            case .high:
                return 3
            case .medium:
                return 2
            case .low:
                return 1
            }
        }
    }
    
    let id: String
    let title: String
    let notes: String
    let date: Date?
    let priority: Priority?
    var done: Bool
    
    private static let inboundDateFormatter = DateFormatter.dateFormatter( format:"yyyy'-'MM'-'dd")
    
    convenience init(dictionary: [String:String]) {
        
        guard let id = dictionary["id"] else {
            fatalError("Missing id")
        }
        let title = dictionary["title"]!
        let notes = dictionary["notes"]!
        let date = dictionary["date"]
        let priority = dictionary["priority"]
        let done = dictionary["done"]!
    
        self.init(
            id: id,
            title: title,
            notes: notes,
            date: (date != nil) ? Todo.convert(date: date!) : nil,
            priority: (priority != nil) ? Priority(rawValue: priority!)! : nil,
            done: (done == "true") )
    }

    init( id: String, title: String, notes: String, date: Date?, priority: Priority?, done: Bool) {
        self.id = id
        self.title = title
        self.notes = notes
        self.date = date
        self.priority = priority
        self.done = done
    }
    
    private static func convert(date: String) -> Date {
        guard let date = Todo.inboundDateFormatter.date( from: date ) else {
            fatalError("Format of date is incorrect")
        }
        return date
    }

}
