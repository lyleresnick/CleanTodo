//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditUseCaseOutput: AnyObject {
    func presentLoading()
    func present(model: TodoItemEditPresentationModel)
    func presentSaveCompleted()
    func presentTitleIsEmpty()
    func present(completeBy: Date?)
    func presentEditItemCancelled()
    func presentCreateItemCancelled()
}

