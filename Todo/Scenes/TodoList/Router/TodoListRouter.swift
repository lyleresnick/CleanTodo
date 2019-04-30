//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoListRouter: class {
    
    func routeDisplayItem(id: String, completion: @escaping TodoListChangedItemCallback )
    func routeCreateItem(completion: @escaping TodoListChangedItemCallback )
}
