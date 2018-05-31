//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListPresenter {
    
    private let useCase: TodoListUseCase
    weak var router: TodoListRouter!
    weak var output: TodoListPresenterOutput!
    
    private var viewModelList: [TodoListViewModel] = []
    
    init(useCase: TodoListUseCase) {
        self.useCase = useCase
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
    
    func eventCompleted(index: Int) {
        useCase.event(completed: true, index: index, id: viewModelList[index].id)
    }
    
    func eventNotCompleted(index: Int) {
        useCase.event(completed: false, index: index, id: viewModelList[index].id)
    }
    
    func eventDelete(index: Int) {
        useCase.eventDelete(index: index, id: viewModelList[index].id)
    }

    func eventCreate() {
        
        router.routeCreateItem() { [weak self] model in
            
            if let strongSelf = self {

                let index = strongSelf.viewModelList.count
                strongSelf.viewModelList.append(TodoListViewModel(model: model))
                strongSelf.output.showAdded(index: index)
            }
        }
    }
    
    func eventItemSelected(index: Int) {
        
        router.routeDisplayItem(id: viewModelList[index].id) { [weak self] model in
            
            if let strongSelf = self {
                strongSelf.viewModelList[index] = TodoListViewModel(model: model)
                strongSelf.output.showChanged(index: index)
            }
        }
    }
    
    func row(at index: Int ) -> TodoListViewModel {
        return viewModelList[index]
    }
    
    var rowCount: Int {
        return viewModelList.count
    }
}

extension TodoListPresenter: TodoListUseCaseOutput {}

extension TodoListPresenter: TodoListViewReadyUseCaseOutput {

    func presentTodoListBegin() {
        viewModelList = []
    }

    func present(model: TodoListPresentationModel) {
        viewModelList.append( TodoListViewModel( model: model ) )
    }

    func presentTodoListEnd() {
        output.showTodoList()
    }
}

extension TodoListPresenter: TodoListCompleteUseCaseOutput {

    func presentCompleted(model: TodoListPresentationModel, index: Int) {
        viewModelList[index] = TodoListViewModel( model: model )
        
        // the output was previously updated due to the immediate toggle state change
        // if this were not the case, an async call would delay the update of the screen
        // if a network error occurs or it turns out the item was deleted by another user, the app should present a message about the situation and, in the former case, reset the button to the previous state; in the latter case the item should be deleted
    }
}

extension TodoListPresenter: TodoListDeleteUseCaseOutput {

    func presentDeleted(index: Int) {
        viewModelList.remove(at: index)
        output.showDeleted(index: index)
    }
}
