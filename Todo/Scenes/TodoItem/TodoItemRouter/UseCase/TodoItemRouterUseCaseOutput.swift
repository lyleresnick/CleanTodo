//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemRouterUseCaseOutput: class {
    
    func presentTitle()
    func presentViewReady(startMode: TodoStartMode)

    func presentNotFound(id: String)
        
    func presentEditView()
    func presentDisplayView()
    func presentChanged(item: TodoListPresentationModel)
}
