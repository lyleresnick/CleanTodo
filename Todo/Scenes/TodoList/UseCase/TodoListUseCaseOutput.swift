//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListUseCaseOutput: AnyObject {
    func present(model: TodoListPresentationModel)
    func presentCompleted(model: TodoListPresentationModel, index: Int)
    func presentChanged(model: TodoListPresentationModel, index: Int)
    func presentDeleted(model: TodoListPresentationModel, index: Int)
    func presentAdded(model: TodoListPresentationModel, index: Int)
    func presentItem()
}
