//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemRouterUseCase {
    
    weak var output: TodoItemRouterUseCaseOutput!
    weak var state: TodoItemUseCaseState!
    
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }

    func eventViewReady(startMode: TodoStartMode) {

        let transformer = TodoItemRouterViewReadyUseCaseTransformer(modelManager: entityGateway.todoManager, state: state)
        transformer.transform(startMode: startMode, output: output)
    }
    
    func eventBack() {
        
        if state.itemChanged {
            output.presentChanged(item: TodoListPresentationModel(entity: state.currentTodo!))
        }
    }
}
