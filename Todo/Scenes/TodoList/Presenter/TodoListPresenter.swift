//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListPresenter {
    
    private let useCase: TodoListUseCase
    weak var router: TodoListRouter!
    weak var output: TodoListPresenterOutput!
    
    
    private var viewModelRowIndex: Int!
    private var viewModelList: [TodoListViewModel] = []
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
    
    func eventDone(index: Int) {
    
        viewModelRowIndex = index
        useCase.eventDone(id: viewModelList[index].id, done: true)
    }
    
    func eventUndone(index: Int) {
        
        viewModelRowIndex = index
        useCase.eventDone(id: viewModelList[index].id, done: false)
    }

    func eventItemSelected( row: Int ) {

        //router.transitionToItem(index: row)
    }
    
    func row(at index: Int ) -> TodoListViewModel {
        return viewModelList[index]
    }
    
    var rowCount: Int {
        return viewModelList.count
    }
}

extension TodoListPresenter: TodoListUseCaseOutput {

    func presentTodoListBegin() {
        viewModelList = []
    }

    func present(model: TodoListPresentationModel) {
        viewModelList.append( TodoListViewModel( model: model ) )
    }

    func presentTodoListEnd() {
        output.showTodoList()
    }
    
    func presentChanged(model: TodoListPresentationModel) {
        viewModelList.replaceSubrange(Range(viewModelRowIndex...viewModelRowIndex), with: [TodoListViewModel( model: model )] )
    }
}
