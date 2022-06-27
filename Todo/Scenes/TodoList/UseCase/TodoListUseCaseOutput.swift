//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListUseCaseOutput: AnyObject {
    func presentLoading()
    func present(model: TodoListPresentationModel)
    func presentCompleted(model: TodoListPresentationModel, index: Int)
    func presentChanged(model: TodoListPresentationModel)
    func presentDeleted(model: TodoListPresentationModel, index: Int)
    func presentItem()
}
