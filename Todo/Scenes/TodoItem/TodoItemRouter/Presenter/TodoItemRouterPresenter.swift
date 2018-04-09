//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation


class TodoItemRouterPresenter {

    private let useCase: TodoItemRouterUseCase
    weak var router: TodoItemRouterRouter!
    var startMode: TodoStartMode!

    weak var output: TodoItemRouterPresenterOutput!
    
    var state = TodoItemRouterUseCaseState()

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

extension TodoItemRouterPresenter: TodoItemRouterUseCaseOutput {
    
    func presentChanged(item: TodoListPresentationModel) {
        
        switch startMode! {
        case let .update(_, changedCompletion):
            changedCompletion(item)
        case let .create(addedCompletion):
            addedCompletion(item)
        }
    }
    
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
        
    func presentEditView() {
        output.showEditView()
    }
    
    func presentDisplayView(){
        output.showDisplayView()
    }
}
    
extension TodoItemRouterPresenter: TodoItemDisplayRouter {
    
    func routeEditView() {
        output.showEditView()
    }
}

extension TodoItemRouterPresenter: TodoItemEditRouter {

    func routeDisplayView() {
        output.showDisplayView()
    }
    
    func routeCreateItemCancelled() {
        router.routeCreateItemCancelled()
    }
}




