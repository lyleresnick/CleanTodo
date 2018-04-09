//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayUseCase {
    
    weak var output: TodoItemDisplayUseCaseOutput!
    weak var state: TodoItemRouterUseCaseState!
    
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }

    func eventViewReady() {

        let transformer = TodoItemDisplayViewReadyUseCaseTransformer(state: state)
        transformer.transform(output: output)
    }
}
