//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoItemEditViewModel {
    
    let title: String
    let note: String
    let completeBy: Date?
    let completeByAsString: String
    let priority: Int
    let completed: Bool

    init( model: TodoItemEditPresentationModel ) {
        title = model.title
        note = model.note
        completeBy = model.completeBy
        completeByAsString = (model.completeBy != nil) ? TodoItemEditViewModel.outboundDateFormatter.string(from: model.completeBy!) : ""

        priority = model.priority.bangs
        completed = model.completed
    }
        
    static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )
}
