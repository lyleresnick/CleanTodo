//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemRouterUseCaseOutput:
    TodoItemRouterViewReadyUseCaseOutput,
    TodoItemRouterBackUseCaseOutput {}


protocol TodoItemRouterViewReadyUseCaseOutput: class {
    
    func presentTitle()
    func presentViewReady(startMode: TodoStartMode)
    func presentNotFound(id: String)
}

protocol TodoItemRouterBackUseCaseOutput: class {
    func presentChanged(item: TodoListPresentationModel)
}

