//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoListViewModel {
    
    
    private static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )

    let id: String
    let title: String
    let notes: String
    let date: String
    let priority: String
    let done: Bool

    
    init(model: TodoListPresentationModel) {
        self.id = model.id
        self.title = model.title
        self.notes = model.notes
        self.date = (model.date != nil) ? TodoListViewModel.outboundDateFormatter.string(from: model.date!) : ""
        self.priority = TodoListViewModel.bangString(priority: model.priority)
        self.done = model.done
        
    }
    
    private static func bangString(priority: Todo.Priority? ) -> String {
    
        let bangCount = priority != nil ? 0 : priority!.bangs
        return (0..<bangCount).reduce("") { result, index in "\(result)!" }
    }

}


