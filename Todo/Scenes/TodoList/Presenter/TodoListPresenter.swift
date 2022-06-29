//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListPresenter {
    private let useCase: TodoListUseCase
    unowned let router: TodoListRouter
    weak var output: TodoListPresenterOutput!
        
    init(useCase: TodoListUseCase, router: TodoListRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
    
    func eventCompleted(index: Int) {
        useCase.event(completed: true, index: index)
    }
    
    func eventNotCompleted(index: Int) {
        useCase.event(completed: false, index: index)
    }
    
    func eventDelete(index: Int) {
        useCase.eventDelete(index: index)
    }

    func eventCreate() {
        useCase.eventCreate()
    }
    
    func eventItemSelected(index: Int) {
        useCase.eventItemSelected(index: index)
    }
}

extension TodoListPresenter: TodoListUseCaseOutput {
    func presentLoading() {
        output.showLoading()
    }
    
    func presentItem() {
        router.routeDisplayItem()
    }

    func present(model: TodoListPresentationModel) {
        output.showTodoList( model: TodoListViewModel( model: model ))
    }

    func presentCompleted(model: TodoListPresentationModel, index: Int) {
        output.showCompleted(model: TodoListViewModel(model: model), index: index)
    }

    func presentChanged(model: TodoListPresentationModel) {
        output.showChanged(model: TodoListViewModel(model: model))
    }

    func presentDeleted(model: TodoListPresentationModel, index: Int) {
        output.showDeleted(model: TodoListViewModel(model: model), index: index)
    }
}
