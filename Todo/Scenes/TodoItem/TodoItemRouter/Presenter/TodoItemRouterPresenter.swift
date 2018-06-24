//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemRouterPresenter {

    private let useCase: TodoItemRouterUseCase
    weak var router: TodoItemRouterRouter!
    var startMode: TodoStartMode!

    weak var output: TodoItemRouterPresenterOutput!
    
    var state = TodoItemUseCaseState()

    init(useCase: TodoItemRouterUseCase) {
        self.useCase = useCase
        useCase.state = state
    }
    
    func eventViewReady() {
        useCase.eventViewReady(startMode: startMode)
    }
    
    func eventBack() {
        useCase.eventBack()
    }
}

extension TodoItemRouterPresenter: TodoItemRouterUseCaseOutput {}
    
extension TodoItemRouterPresenter: TodoItemRouterBackUseCaseOutput {

    func presentChanged(item: TodoListPresentationModel) {
        
        switch startMode! {
        case let .update(_, changedCompletion):
            changedCompletion(item)
        case let .create(addedCompletion):
            addedCompletion(item)
        }
    }
}

extension TodoItemRouterPresenter: TodoItemRouterViewReadyUseCaseOutput {
    
    func presentTitle() {
        output.show(title: title )
    }

    func presentViewReady(startMode: TodoStartMode) {
        output.showViewReady(startMode: startMode)
    }
    
    private var title: String {
        return "todo".localized
    }

    func presentNotFound(id: String) {
        
        let messageFormat = "todoNotFound".localized
        let message = String(format: messageFormat, id)
        output.showView(message: message )
    }
}
    
extension TodoItemRouterPresenter: TodoItemDisplayRouter {
    
    func routeEditView() {
        output.showEditView()
    }
}

extension TodoItemRouterPresenter: TodoItemEditRouter {
    
    func routeSaveCompleted() {
        output.showDisplayView()
    }
    
    func routeEditingCancelled() {
        
        switch startMode! {
        case .update:
            output.showDisplayView()
        case .create:
            router.routeCreateItemCancelled()
        }
    }
    
    
}




