//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemEditRouter: class {
    
    var state: TodoItemUseCaseState {get}
    
    func routeEditingCancelled()
    func routeSaveCompleted()
}
