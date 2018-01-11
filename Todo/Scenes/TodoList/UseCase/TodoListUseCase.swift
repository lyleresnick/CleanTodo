//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoListUseCase {
    
    weak var output: TodoListUseCaseOutput!
    
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }

    func eventViewReady(transformer: TodoListUseCaseTransformer! = nil) {

        var transformer: TodoListUseCaseTransformer! = transformer
        if transformer == nil {
            transformer = TodoListUseCaseTransformer(todoManager: entityGateway.todoManager)
        }
        transformer.transform(output: output)
    }
}
