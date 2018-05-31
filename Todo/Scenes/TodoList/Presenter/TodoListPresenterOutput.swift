//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListPresenterOutput: class,
    TodoListViewReadyPresenterOutput,
    TodoListCreatePresenterOutput,
    TodoListDeletePresenterOutput,
    TodoListChangedPresenterOutput {}

protocol TodoListViewReadyPresenterOutput {
    func showTodoList()
}

protocol TodoListCreatePresenterOutput {
    func showAdded(index: Int)
}

protocol TodoListDeletePresenterOutput {
    func showDeleted(index: Int)
}

protocol TodoListChangedPresenterOutput {
    func showChanged(index: Int)
}

