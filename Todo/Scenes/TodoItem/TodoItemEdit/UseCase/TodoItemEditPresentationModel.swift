//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoItemEditPresentationModel {

    let id: String
    let title: String
    let note: String
    let completeBy: Date?
    let priority: Int
    var completed: Bool

    init( entity: Todo ) {
        id = entity.id
        title = entity.title
        note = entity.note
        completeBy = entity.completeBy
        self.priority = entity.priority != nil ? entity.priority!.bangs : 0
        completed = entity.completed
    }
}
