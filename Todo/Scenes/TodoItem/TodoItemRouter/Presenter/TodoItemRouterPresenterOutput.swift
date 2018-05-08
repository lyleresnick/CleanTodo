//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemRouterPresenterOutput:
    TodoItemRouterViewReadyPresenterOutput,
    TodoItemRouterDisplayPresenterOutput,
    TodoItemRouterEditPresenterOutput {}


protocol TodoItemRouterViewReadyPresenterOutput: class {

    func show(title: String)
    func showViewReady(startMode: TodoStartMode)
    func showView(message: String)
}

protocol TodoItemRouterDisplayPresenterOutput: class {
    func showDisplayView()
}

protocol TodoItemRouterEditPresenterOutput: class {
    func showEditView()
}
