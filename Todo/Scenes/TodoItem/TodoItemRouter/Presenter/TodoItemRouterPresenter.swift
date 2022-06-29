//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemRouterPresenter {
    private let useCase: TodoItemRouterUseCase
    unowned let router: TodoItemRouterRouter!
    var startMode: TodoItemStartMode!
    weak var output: TodoItemRouterPresenterOutput!
    
    init(useCase: TodoItemRouterUseCase, router: TodoItemRouterRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
}

extension TodoItemRouterPresenter: TodoItemRouterUseCaseOutput {
    func presentTitle() {
        output.show(title: title )
    }

    func presentEditView() {
        output.showEditView()
    }
    
    func presentDisplayView() {
        output.showDisplayView()
    }
    
    private var title: String {
        return "todo".localized
    }

    func presentNotFound(id: String) {
        let messageFormat = "todoNotFound".localized
        let message = String(format: messageFormat, id)
        output.showMessageView(message: message )
    }
}
    
extension TodoItemRouterPresenter: TodoItemDisplayRouter {
    func routeEditView() {
        output.showEditView()
    }
}

extension TodoItemRouterPresenter: TodoItemEditRouter {
    func presentLoading() {
        output.showLoading()
    }
    
    func routeCreateItemCancelled() {
        router.routeCreateItemCancelled()
    }
    
    func routeSaveCompleted() {
        output.showDisplayView()
    }
    
    func routeEditItemCancelled() {
        output.showDisplayView()
    }
}




