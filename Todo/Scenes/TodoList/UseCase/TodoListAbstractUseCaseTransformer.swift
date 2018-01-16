//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListAbstractUseCaseTransformer {
    
    let todoManager: TodoManager

    init(todoManager:  TodoManager) {
        self.todoManager = todoManager
    }
}
