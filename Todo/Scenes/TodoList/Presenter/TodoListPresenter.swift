//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListPresenter {
    
    private let useCase: TodoListUseCase
    weak var router: TodoListRouter!
    weak var output: TodoListPresenterOutput!
        
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
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
    func presentAdded(model: TodoListPresentationModel, index: Int) {
        output.showAdded( model: TodoListViewModel( model: model ), index: index)
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

    func presentChanged(model: TodoListPresentationModel, index: Int) {
        output.showChanged(model: TodoListViewModel(model: model), index: index)
    }

    func presentDeleted(model: TodoListPresentationModel, index: Int) {
        output.showDeleted(model: TodoListViewModel(model: model), index: index)
    }
}
