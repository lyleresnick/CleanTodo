//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoRootRouterPresenterOutput:
    TodoRootRouterListPresenterOutput,
    TodoRootRouterItemPresenterOutput {}

protocol TodoRootRouterListPresenterOutput: class {
    
    func showItem(id: String, completion: @escaping TodoListChangedItemCallback)
    func showCreateItem(completion: @escaping TodoListChangedItemCallback)
}

protocol TodoRootRouterItemPresenterOutput: class {
    func showPop()
}
