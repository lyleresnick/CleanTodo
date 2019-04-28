//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayUseCase {
    
    weak var output: TodoItemDisplayUseCaseOutput!
    private let entityGateway: EntityGateway
    private let itemState: TodoItemUseCaseState

    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway,
          useCaseStore: UseCaseStore = RealUseCaseStore.store ) {
        self.entityGateway = entityGateway
        self.itemState = useCaseStore[itemStateKey] as! TodoItemUseCaseState
    }

    func eventViewReady() {

        let transformer = TodoItemDisplayViewReadyUseCaseTransformer(state: itemState)
        transformer.transform(output: output)
    }
}
