//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditPresenterOutput: class {
    
    func show(model: TodoItemEditViewModel)
    func showNewModel()
    
    func show(completeBy: String)
    
    func showKeyboard(completeBy: Date?)
    func showKeyboardHidden()
    
    func showTitleIsEmpty(alertTitle: String, message: String)
}
