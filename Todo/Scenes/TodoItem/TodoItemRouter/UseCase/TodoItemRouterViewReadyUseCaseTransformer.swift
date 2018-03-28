//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemRouterViewReadyUseCaseTransformer {
    
    private let modelManager: TodoManager
    private let cache: TodoItemRouterUseCaseCache

    init(modelManager: TodoManager, cache: TodoItemRouterUseCaseCache) {
        self.modelManager = modelManager
        self.cache = cache
    }

    func transform( startMode: TodoStartMode, output: TodoItemRouterUseCaseOutput )  {
        
        switch startMode {
        case .create:
            startCreate(startMode: startMode, output: output)
        case .update(let id, _):
            startUpdate(startMode: startMode, id: id, output: output)
        }
    }
    
    private func startCreate(startMode: TodoStartMode, output: TodoItemRouterUseCaseOutput) {
        
        cache.currentTodo = nil
        output.presentViewReady(startMode: startMode)
    }

    private func startUpdate(startMode: TodoStartMode, id: String, output: TodoItemRouterUseCaseOutput) {
        
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
                
                self.cache.currentTodo = todo
                output.presentViewReady(startMode: startMode)
            }
        }
    }
}
