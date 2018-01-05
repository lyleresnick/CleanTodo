//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListPresenterOutput: class {
    
    func showModels()
    
    func showNotFound(message: String)
    func showOtherSemanticResult()
    
    func showNetworkError()
    func showUnknownError()
}
