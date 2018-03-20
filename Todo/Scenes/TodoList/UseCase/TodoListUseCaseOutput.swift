//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListUseCaseOutput: class {
    
    func presentTodoListBegin()
    func present(model: TodoListPresentationModel)
    func presentTodoListEnd()
    func presentChanged(model: TodoListPresentationModel, index: Int)
    func presentChangedNoUpdate(model: TodoListPresentationModel, index: Int)

    func presentDeleted(index: Int)
}
