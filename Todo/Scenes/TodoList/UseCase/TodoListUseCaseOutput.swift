//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListUseCaseOutput: class {
    
    func presentModelListBegin()
    func present(model: TodoListPresentationModel)
    func presentModelListEnd()

    func presentNetworkError(code:Int)
    func presentUnknownError(code:Int)

    func presentNotFound(message: String)
    func presentOtherSemanticResult()
}
