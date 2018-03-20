//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

typealias TodoListChangedItemCallback = (TodoListPresentationModel) -> ()

protocol TodoListRouter: class {
    
    func routeItem(id: String, completion: @escaping TodoListChangedItemCallback )
    func routeCreateItem(completion: @escaping TodoListChangedItemCallback )
}
