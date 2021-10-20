//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemRouterPresenterOutput: AnyObject {
    func show(title: String)
    func showEditView()
    func showDisplayView()
    func showView(message: String)
}
