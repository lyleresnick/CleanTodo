//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditPresenterOutput:
    TodoItemEditViewReadyPresenterOutput,
    TodoItemEditCompleteByPresenterOutput,
    TodoItemEditSavePresenterOutput {}

protocol TodoItemEditViewReadyPresenterOutput: class {
    func show(model: TodoItemEditViewModel, titlePlaceholder: String, priorityLabels: [String])
}

protocol TodoItemEditCompleteByPresenterOutput: class {
    
    func show(completeBy: String)
    func showEnableEdit(completeBy: Date?)
    func showCompleteByClear()
}

protocol TodoItemEditSavePresenterOutput: class {
    func showAlert(alertTitle: String, message: String, actionTitle: String)
}
