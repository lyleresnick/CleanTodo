//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditPresenterOutput:
    TodoItemEditViewReadyPresenterOutput,
    TodoItemEditCompleteByPresenterOutput,
    TodoItemEditSavePresenterOutput {}

protocol TodoItemEditViewReadyPresenterOutput: class {
    
    func show(model: TodoItemEditViewModel)
    func showNewModel()
}

protocol TodoItemEditCompleteByPresenterOutput: class {
    
    func show(completeBy: String)
    func showKeyboard(completeBy: Date?)
    func showKeyboardHidden()
}

protocol TodoItemEditSavePresenterOutput: class {
    func showTitleIsEmpty(alertTitle: String, message: String)
}
