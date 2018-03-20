//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditUseCaseOutput: class {
    
    func present(model: TodoItemEditPresentationModel)
    func presentNewModel()
    
    func presentDisplayView()
    
    func presentKeyboard(completeBy: Date?)
    func presentKeyboardHidden()
    func present(completeBy: Date?)
    
    func presentTitleIsEmpty()
}
