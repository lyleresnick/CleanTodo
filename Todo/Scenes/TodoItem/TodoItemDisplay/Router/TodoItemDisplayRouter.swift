//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemDisplayRouter: class {
    
    var cache: TodoItemRouterUseCaseCache {get}

    func routeEditView()
}
