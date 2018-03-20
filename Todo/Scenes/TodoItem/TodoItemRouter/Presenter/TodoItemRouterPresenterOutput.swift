//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemRouterPresenterOutput: class {

    func show(title: String)
    func showViewReady(startMode: TodoStartMode)
    func showDisplayView()
    func showEditView()
    func showView(message: String) 
}
