
//  Copyright © 2018 Lyle Resnick. All rights reserved.

import Foundation

extension Todo {
    
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
            completeBy: (completeBy != nil) ? Todo.convert(date: completeBy!) : nil,
            priority: Priority(rawValue: priority)!,
            completed: (completed == "true") )
    }
    
    private static func convert(date: String) -> Date {
        guard let date = Todo.inboundDateFormatter.date( from: date ) else {
            fatalError("Format of date is incorrect")
        }
        return date
    }
}
