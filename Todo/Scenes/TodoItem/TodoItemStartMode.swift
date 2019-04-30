//  Copyright © 2019 Lyle Resnick. All rights reserved.

typealias TodoListChangedItemCallback = (TodoListPresentationModel) -> ()

enum TodoStartMode {
    case create(completion: TodoListChangedItemCallback)
    case update(id: String, completion: TodoListChangedItemCallback)
}
