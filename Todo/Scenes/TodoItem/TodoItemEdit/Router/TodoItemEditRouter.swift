//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemEditRouter: class {
    
    var state: TodoItemRouterUseCaseState {get}
    
    func routeDisplayView()
    func routeCreateItemCancelled()
}
