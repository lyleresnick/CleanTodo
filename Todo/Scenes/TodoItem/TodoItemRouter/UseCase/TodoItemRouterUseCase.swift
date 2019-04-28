//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemRouterUseCase {
    
    weak var output: TodoItemRouterUseCaseOutput!
    
    private var entityGateway: EntityGateway
    private var useCaseStore: UseCaseStore
    private var itemState = TodoItemUseCaseState()

    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway,
          useCaseStore: UseCaseStore = RealUseCaseStore.store ) {
        
        self.entityGateway = entityGateway
        self.useCaseStore = useCaseStore
        self.useCaseStore[itemStateKey] = itemState
    }

    func eventViewReady(startMode: TodoStartMode) {

        let transformer = TodoItemRouterViewReadyUseCaseTransformer(modelManager: entityGateway.todoManager, state: itemState)
        transformer.transform(startMode: startMode, output: output)
    }
    
    func eventBack() {
        
        if itemState.itemChanged {
            output.presentChanged(item: TodoListPresentationModel(entity: itemState.currentTodo!))
        }
    }
    
    deinit {
        useCaseStore[itemStateKey] = nil
    }
}
