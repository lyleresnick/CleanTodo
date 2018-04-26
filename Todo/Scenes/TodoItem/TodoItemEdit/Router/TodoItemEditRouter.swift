//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemEditRouter: class {
    
    var state: TodoItemUseCaseState {get}
    
    func routeDisplayView()
    func routeCreateItemCancelled()
}
