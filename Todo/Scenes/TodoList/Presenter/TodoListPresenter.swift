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
        useCase.eventViewReady(parameter: "Hello" )
    }
    
    func eventItemSelected( row: Int ) {

        router.transitionToItem(index: row)
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
        output.showModels()
    }
}
