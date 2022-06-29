//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoRouterPresenter {
    weak var output: TodoRouterPresenterOutput!
    
    func eventViewReady() {
        output.showReady()
    }
}

extension TodoRouterPresenter: TodoItemRouterRouter {
    func routeCreateItemCancelled() {
        output.showPop()
    }
}

extension TodoRouterPresenter: TodoListRouter {
    func routeDisplayItem() {
        output.showItem()
    }
}
