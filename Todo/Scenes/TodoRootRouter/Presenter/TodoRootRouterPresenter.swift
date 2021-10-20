//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoRootRouterPresenter {
    
    weak var output: TodoRootRouterPresenterOutput!
}

extension TodoRootRouterPresenter: TodoItemRouterRouter {
    
    func routeCreateItemCancelled() {
        output.showPop()
    }
}

extension TodoRootRouterPresenter: TodoListRouter {
    func routeDisplayItem() {
        output.showItem()
    }
}
