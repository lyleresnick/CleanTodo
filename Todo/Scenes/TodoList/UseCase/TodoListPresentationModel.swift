//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoListPresentationModel {
    let todoList: [TodoListRowPresentationModel];
    
    init(todoList: [Todo]) {
        self.todoList = todoList.map { TodoListRowPresentationModel(entity: $0) }
    }
}

struct TodoListRowPresentationModel {
    let id: String
    let title: String
    let completeBy: Date?
    let priority: Priority
    let completed: Bool
    
    init(entity: Todo) {
        id = entity.id
        title = entity.title
        completeBy = entity.completeBy
        priority = entity.priority
        completed = entity.completed
    }
}
