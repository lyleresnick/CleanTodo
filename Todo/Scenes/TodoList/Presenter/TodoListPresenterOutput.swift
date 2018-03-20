//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListPresenterOutput: class {
    
    func showTodoList()
    func showDeleted(index: Int)
    func showChanged(index: Int)
    func showAdded(index: Int)
}
