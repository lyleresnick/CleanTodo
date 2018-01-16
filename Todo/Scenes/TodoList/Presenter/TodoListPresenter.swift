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
        useCase.event(done: true, id: viewModelList[index].id)
    }
    
    func eventUndone(index: Int) {
        
        viewModelRowIndex = index
        useCase.event(done: false, id: viewModelList[index].id)
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
        
        // the output is already updated
        // if this were not the case, an async call would delay the update of the screen
        // if a network error occurs or it turns out the item was deleted by another user, the app should present a message about the situation and, in the former case, reset the button to the previous state; in the latter case the item should be deleted
    }
}
