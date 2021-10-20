//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoListPresentationModel {
    let todoList: [TodoListRowPresentationModel];
    
    init(entityList: [Todo]) {
        todoList = entityList.map { TodoListRowPresentationModel(entity: $0) }
    }
}

struct TodoListRowPresentationModel {
    
    let id: String
    let title: String
    let completeBy: Date?
    let priority: Int
    let completed: Bool
    
    init(entity: Todo) {
        self.id = entity.id
        self.title = entity.title
        self.completeBy = entity.completeBy
        self.priority = entity.priority.bangs
        self.completed = entity.completed
    }
}
