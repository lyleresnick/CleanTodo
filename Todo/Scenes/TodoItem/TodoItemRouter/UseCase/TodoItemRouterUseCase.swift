//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemRouterUseCase {
    
    weak var output: TodoItemRouterUseCaseOutput!
    weak var cache: TodoItemRouterUseCaseCache!
    
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }

    func eventViewReady(startMode: TodoStartMode) {

        let transformer = TodoItemRouterViewReadyUseCaseTransformer(modelManager: entityGateway.todoManager, cache: cache)
        transformer.transform(startMode: startMode, output: output)
    }
    
    func eventBack() {
        
        if cache.itemChanged {
            output.presentChanged(item: TodoListPresentationModel(entity: cache.currentTodo!))
        }
    }
}
