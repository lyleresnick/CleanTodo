//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListUseCaseOutput:
    TodoListViewReadyUseCaseOutput,
    TodoListCompleteUseCaseOutput,
    TodoListDeleteUseCaseOutput {}

protocol TodoListViewReadyUseCaseOutput: class {
    
    func presentTodoListBegin()
    func present(model: TodoListPresentationModel)
    func presentTodoListEnd()
}

protocol TodoListCompleteUseCaseOutput: class {
    func presentCompleted(model: TodoListPresentationModel, index: Int)
}

protocol TodoListDeleteUseCaseOutput: class {
    func presentDeleted(index: Int)
}
