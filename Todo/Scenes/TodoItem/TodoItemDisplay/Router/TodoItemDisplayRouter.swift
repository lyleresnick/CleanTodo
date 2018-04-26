//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemDisplayRouter: class {
    
    var state: TodoItemUseCaseState {get}

    func routeEditView()
}
