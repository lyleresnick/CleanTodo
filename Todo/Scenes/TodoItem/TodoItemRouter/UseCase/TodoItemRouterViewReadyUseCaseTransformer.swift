//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemRouterViewReadyUseCaseTransformer {
    
    private let modelManager: TodoManager
    private let state: TodoItemUseCaseState

    init(modelManager: TodoManager, state: TodoItemUseCaseState) {
        self.modelManager = modelManager
        self.state = state
    }

    func transform( startMode: TodoStartMode, output: TodoItemRouterViewReadyUseCaseOutput )  {
        
        switch startMode {
        case .create:
            startCreate(startMode: startMode, output: output)
        case .update(let id, _):
            startUpdate(startMode: startMode, id: id, output: output)
        }
    }
    
    private func startCreate(startMode: TodoStartMode, output: TodoItemRouterViewReadyUseCaseOutput) {
        
        state.currentTodo = nil
        output.presentViewReady(startMode: startMode)
    }

    private func startUpdate(startMode: TodoStartMode, id: String, output: TodoItemRouterViewReadyUseCaseOutput) {
        
        modelManager.fetch(id: id) { [weak output] result in
            
            guard let output = output else { return }
            
            output.presentTitle()
            
            switch result {
            case let .semanticError(reason):
                
                switch(reason) {
                case .notFound:
                    output.presentNotFound(id: id)
                }
                
            case let .failure(error):
                
                fatalError("Unresolved error: \(error.description)")

            case let .success(todo):
                
                self.state.currentTodo = todo
                output.presentViewReady(startMode: startMode)
            }
        }
    }
}
