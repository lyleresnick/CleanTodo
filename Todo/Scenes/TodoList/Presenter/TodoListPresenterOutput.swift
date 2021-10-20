//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListPresenterOutput: AnyObject {
    func showTodoList(model: TodoListViewModel)
    func showAdded(model: TodoListViewModel, index: Int)
    func showDeleted(model: TodoListViewModel, index: Int)
    func showCompleted(model: TodoListViewModel, index: Int)
    func showChanged(model: TodoListViewModel, index: Int)
}

