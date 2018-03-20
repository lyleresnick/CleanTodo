//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoListViewModel {
    
    let id: String
    let title: String
    let completeBy: String
    let priority: String
    let completed: Bool
    
    init(model: TodoListPresentationModel) {
        self.id = model.id
        self.title = model.title
        self.completeBy = (model.completeBy != nil) ? TodoListViewModel.outboundDateFormatter.string(from: model.completeBy!) : ""
        self.priority = (0..<model.priority).reduce(" ") { result, index in "!\(result)" }
        self.completed = model.completed
    }
    
    private static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )
}


