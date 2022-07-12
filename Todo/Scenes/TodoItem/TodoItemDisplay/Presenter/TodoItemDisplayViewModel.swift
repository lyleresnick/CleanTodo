//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

struct TodoItemDisplayViewModel {
    let rows: [TodoItemDisplayRowViewModel]
    
    init(model: TodoItemDisplayPresentationModel) {
        rows = model.rows.map {TodoItemDisplayRowViewModel(row: $0)}
    }
}

struct TodoItemDisplayRowViewModel {
    let fieldName: String
    let value: String
    private static var outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )

    init(row: TodoItemDisplayRowPresentationModel) {
        fieldName = row.field.rawValue.localized
        switch(row.value) {
        case let .string(value):
            self.value = value
        case let .date(value):
            self.value = TodoItemDisplayRowViewModel.outboundDateFormatter.string(from: value)
        case let .bool(value):
            self.value = (value ? "yes" : "no").localized
        case let .priority(value):
            self.value = value.rawValue.localized
        }
    }
}


