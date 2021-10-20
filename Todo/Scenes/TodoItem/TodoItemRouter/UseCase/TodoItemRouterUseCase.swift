//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemRouterUseCase {
    
    weak var output: TodoItemRouterUseCaseOutput!
    
    private var entityGateway: EntityGateway
    private var appState: AppState

    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway,
          appState: AppState = TodoAppState.instance ) {
        
        self.entityGateway = entityGateway
        self.appState = appState
        appState.itemState = TodoItemState()
    }

    func eventViewReady() {

        switch appState.itemStartMode! {
        case .create:
            startCreate()
        case .update(let index, _):
            startUpdate(index: index)
        }
    }
    private func startCreate() {
        
        appState.itemState.currentTodo = nil
        output.presentEditView()
    }

    private func startUpdate(index: Int) {
        
        let id = appState.todoList[index].id
        entityGateway.todoManager.fetch(id: id) { [self, weak output] result in
            guard let output = output else { return }
            output.presentTitle()

            switch result {
            case let .semantic(reason):
                switch(reason) {
                case .notFound:
                    output.presentNotFound(id: id)
                case .noData:
                    fatalError("semantic event \(reason) is not being processed!")
                }
            case let .failure(_, code, description):
                fatalError("Unresolved error: code: \(code), \(description)")
            case let .success(todo):
                appState.itemState.currentTodo = todo
                output.presentDisplayView()
            }
        }
    }

    
    func eventBack() {
        
        if appState.itemState.itemChanged {
            switch appState.itemStartMode! {
            case .create(let changedItemCallback):
                changedItemCallback()
            case .update(_, let changedItemCallback):
                changedItemCallback()
            }
        }
    }

}
