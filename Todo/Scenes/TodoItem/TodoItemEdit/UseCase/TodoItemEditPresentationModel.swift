//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoItemEditPresentationModel {
    let title: String
    let note: String
    let completeBy: Date?
    let priority: Priority
    var completed: Bool

    init( entity: Todo ) {
        title = entity.title
        note = entity.note
        completeBy = entity.completeBy
        priority = entity.priority
        completed = entity.completed
    }
}
