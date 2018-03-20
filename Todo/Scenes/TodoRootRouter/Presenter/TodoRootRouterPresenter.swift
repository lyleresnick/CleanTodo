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
    
    func routeCreateItem(completion: @escaping TodoListChangedItemCallback) {
        output.showCreateItem(completion: completion)
    }
    
    func routeItem(id: String, completion: @escaping TodoListChangedItemCallback) {
        output.showItem(id: id, completion: completion)
    }
}
