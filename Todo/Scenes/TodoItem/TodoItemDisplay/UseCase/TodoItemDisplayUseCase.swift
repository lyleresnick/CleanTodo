//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayUseCase {
    
    weak var output: TodoItemDisplayUseCaseOutput!
    private let itemState: TodoItemUseCaseState

    init(useCaseStore: UseCaseStore = RealUseCaseStore.store ) {
        itemState = useCaseStore[itemStateKey] as! TodoItemUseCaseState
    }

    func eventViewReady() {

        let transformer = TodoItemDisplayViewReadyUseCaseTransformer(state: itemState)
        transformer.transform(output: output)
    }
}
