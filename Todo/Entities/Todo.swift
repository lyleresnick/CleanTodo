//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class Todo {
    
    enum Priority: String {
        case high
        case medium
        case low
        
        var bangs: Int {
            get {
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
        
        init!(bangs: Int ) {
            
            var rawValue: String!
            switch bangs {
            case 3:
                rawValue = "high"
            case 2:
                rawValue = "medium"
            case 1:
                rawValue = "low"
            default:
                fatalError("bangs must be 1, 2 or 3")
            }
            self.init(rawValue: rawValue)
        }
    }
    
    var id: String
    var title: String
    var note: String
    var completeBy: Date?
    var priority: Priority?
    var completed: Bool
    
    
    init( id: String, title: String, note: String = "", completeBy: Date? = nil, priority: Priority? = nil, completed: Bool = false) {
        self.id = id
        self.title = title
        self.note = note
        self.completeBy = completeBy
        self.priority = priority
        self.completed = completed
    }
}


