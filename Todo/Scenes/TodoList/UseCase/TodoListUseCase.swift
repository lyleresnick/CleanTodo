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
    
    func event(done: Bool, at row: Int, id: String) {
        let transformer = TodoListDoneUseCaseTransformer(todoManager: entityGateway.todoManager)
        transformer.transform(done: done, at: row, id: id, output: output)
    }
}
