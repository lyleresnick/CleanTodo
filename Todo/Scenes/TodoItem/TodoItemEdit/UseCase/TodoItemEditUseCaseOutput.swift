//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditUseCaseOutput:
    TodoItemEditViewReadyUseCaseOutput,
    TodoItemEditSaveUseCaseOutput,
    TodoItemEditCompleteByUseCaseOutput {}

protocol TodoItemEditViewReadyUseCaseOutput: class {
    
    func present(model: TodoItemEditPresentationModel)
    func presentNewModel()
}

protocol TodoItemEditSaveUseCaseOutput: class {
    
    func presentSaveCompleted()
    func presentTitleIsEmpty()
}

protocol TodoItemEditCompleteByUseCaseOutput: class {
    
    func presentEnableEdit(completeBy: Date?)
    func presentCompleteByClear()
    func present(completeBy: Date?)
}

