//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoListUseCase {
    
    weak var output: TodoListUseCaseOutput!
    
    private let entityGateway: EntityGateway
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }

    func eventViewReady() {

        let transformer = TodoListViewReadyUseCaseTransformer(todoManager: entityGateway.todoManager)
        transformer.transform(output: output)
    }
    
    func eventDone(id: String, done: Bool) {
        let transformer = TodoListDoneUseCaseTransformer(todoManager: entityGateway.todoManager)
        transformer.transform(id: id, done: done, output: output)
    }
}
