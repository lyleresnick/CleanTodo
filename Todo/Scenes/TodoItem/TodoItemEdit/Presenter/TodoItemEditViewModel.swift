//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoItemEditViewModel {
    
    let id: String
    let title: String
    let note: String
    let completeBy: Date?
    let completeByString: String
    let priority: Int
    var completed: Bool

    init( model: TodoItemEditPresentationModel ) {
        id = model.id
        title = model.title
        note = model.note
        completeBy = model.completeBy
        completeByString = (model.completeBy != nil) ? TodoItemEditViewModel.outboundDateFormatter.string(from: model.completeBy!) : ""

        self.priority = model.priority
        completed = model.completed
    }
    
    static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )
}
