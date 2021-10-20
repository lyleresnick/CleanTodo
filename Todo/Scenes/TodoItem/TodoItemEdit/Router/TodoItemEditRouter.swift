//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemEditRouter: AnyObject {
    func routeEditItemCancelled()
    func routeCreateItemCancelled()
    func routeSaveCompleted()
}
