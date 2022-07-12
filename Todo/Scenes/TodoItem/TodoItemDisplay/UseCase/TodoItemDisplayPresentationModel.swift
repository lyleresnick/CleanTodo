//
//  TodoItemDisplayPresenterModel.swift
//  Todo
//
//  Created by Lyle Resnick on 2022-07-11.
//  Copyright © 2022 Lyle Resnick. All rights reserved.
//

import Foundation

struct TodoItemDisplayPresentationModel {
    let rows: [TodoItemDisplayRowPresentationModel]
}

struct TodoItemDisplayRowPresentationModel {
    let field: FieldName
    enum Value {
        case string(String)
        case date(Date)
        case bool(Bool)
        case priority(Priority)
    }
    let value: Value
}
