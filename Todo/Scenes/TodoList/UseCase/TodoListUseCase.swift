//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoListUseCase {
    
    weak var output: TodoListUseCaseOutput!
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway ) {
        self.entityGateway = entityGateway
    }

    func eventViewReady() {

        let transformer = TodoListViewReadyUseCaseTransformer(todoManager: entityGateway.todoManager)
        transformer.transform(output: output)
    }
    
    func event(completed: Bool, index: Int, id: String) {
        
        let transformer = TodoListCompletedUseCaseTransformer(todoManager: entityGateway.todoManager)
        transformer.transform(completed: completed, index: index, id: id, output: output)
    }
    
    func eventDelete(index: Int, id: String) {
        
        let transformer = TodoListDeleteUseCaseTransformer(todoManager: entityGateway.todoManager)
        transformer.transform(index: index, id: id, output: output)
    }
}
