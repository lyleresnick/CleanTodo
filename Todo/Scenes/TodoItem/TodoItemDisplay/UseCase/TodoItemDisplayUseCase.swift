//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayUseCase {
    
    weak var output: TodoItemDisplayUseCaseOutput!
    weak var cache: TodoItemRouterUseCaseCache!
    
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }

    func eventViewReady() {

        let transformer = TodoItemDisplayViewReadyUseCaseTransformer(cache: cache)
        transformer.transform(output: output)
    }
}
