//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

enum FieldName: String {
    case title
    case note
    case completeBy
    case priority
    case completed
}

protocol TodoItemDisplayUseCaseOutput: AnyObject {
    func present(model: TodoItemDisplayPresentationModel )
}



