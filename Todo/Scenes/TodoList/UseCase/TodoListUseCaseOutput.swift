//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListUseCaseOutput: class {
    
    func presentTodoListBegin()
    func present(model: TodoListPresentationModel)
    func presentTodoListEnd()
}
