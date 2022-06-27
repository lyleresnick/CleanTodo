//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoListViewModel {
    let todoList: [TodoListRowViewModel]
    
    init(model: TodoListPresentationModel) {
        todoList = model.todoList.map { TodoListRowViewModel(model: $0) }
    }
}

struct TodoListRowViewModel {
    
    let id: String
    let title: String
    let completeBy: String
    let priority: String
    let completed: Bool
    
    init(model: TodoListRowPresentationModel) {
        id = model.id
        title = model.title
        completeBy = (model.completeBy != nil) ? Self.outboundDateFormatter.string(from: model.completeBy!) : ""
        priority = (0..<model.priority.bangs).reduce(" ") { result, _ in "!\(result)" }
        completed = model.completed
    }
    
    private static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )
}


