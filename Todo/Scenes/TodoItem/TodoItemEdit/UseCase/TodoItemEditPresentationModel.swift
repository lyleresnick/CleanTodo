//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoItemEditPresentationModel {
    let title: String
    let note: String
    let completeBy: Date?
    let priority: Priority
    var completed: Bool

    init( editingTodo: TodoItemEditUseCase.EditingTodo ) {
        title = editingTodo.title
        note = editingTodo.note
        completeBy = editingTodo.completeBy
        priority = editingTodo.priority
        completed = editingTodo.completed
    }

}
