//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

enum FieldName: String {
    case title
    case note
    case completeBy
    case priority
    case completed
}

protocol TodoItemDisplayUseCaseOutput: class {
    
    func presentBegin()
    func present(field: FieldName, value: String)
    func present(field: FieldName, value: Date)
    func present(field: FieldName, value: Bool)
    func present(field: FieldName, value: Todo.Priority)
    func presentEnd()
    
}
