//  Copyright © 2023 Lyle Resnick. All rights reserved.

import Foundation

struct TodoParams: Encodable {
    let title: String
    let note: String
    let completeBy: Date?
    let priority: String
    let completed: Bool
    
    init(values: TodoValues) {
        self.title = values.title
        self.note = values.note
        self.completeBy = values.completeBy
        self.priority = values.priority.rawValue
        self.completed = values.completed
    }
    

}



