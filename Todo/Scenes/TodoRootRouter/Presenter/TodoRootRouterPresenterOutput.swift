//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoRootRouterPresenterOutput: class {
    
    func showItem(id: String, completion: @escaping TodoListChangedItemCallback)
    func showCreateItem(completion: @escaping TodoListChangedItemCallback)
    
    func showPop()
}
