//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemEditRouter: class {
    
    var cache: TodoItemRouterUseCaseCache {get}
    
    func routeDisplayView()
    func routeCreateItemCancelled()
}
