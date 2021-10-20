//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoListUseCase {
    
    weak var output: TodoListUseCaseOutput!
    let entityGateway: EntityGateway
    let appState: AppState
    
    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway, appState: AppState = TodoAppState.instance ) {
        self.entityGateway = entityGateway
        self.appState = appState
    }

    func eventViewReady() {
        entityGateway.todoManager.all() { [self, weak output] result in
            guard let output = output else { return }
            switch result {
            case let .semantic(event):
               fatalError("semantic event \(event) is not being processed!")
            case let .failure(_, code, description):
                fatalError("Unresolved error: code: \(code), \(description)")
            case let .success(todoList):
                appState.todoList = todoList;
                output.present(model: presentationModelFromAppState())
            }
        }
    }
    
    private func presentationModelFromAppState() -> TodoListPresentationModel {
        return TodoListPresentationModel(entityList: appState.todoList)
    }
    
    func event(completed: Bool, index: Int) {
        let id = appState.todoList[index].id
        entityGateway.todoManager.completed(id: id, completed: completed) { [self, weak output] result in
            guard let output = output else { return }
            switch result {
            case let .semantic(event):
               fatalError("semantic event: \(event) is not being processed!")
            case let .failure(_, code, description):
                fatalError("Unresolved error: code: \(code), \(description)")
            case let .success(entity):
                appState.todoList[index] = entity;
                output.presentCompleted(model: presentationModelFromAppState(), index: index)
            }
        }
    }
    
    func eventDelete(index: Int) {
        let id = appState.todoList[index].id
        entityGateway.todoManager.delete(id: id) { [self, weak output] result in
            guard let output = output else { return }
            switch result {
            case let .semantic(reason):
                switch(reason) {
                case .notFound:
                    fatalError("semantic event \(reason) is not being processed!")
                case .noData:
                    appState.todoList.remove(at: index);
                    output.presentDeleted(model: presentationModelFromAppState(), index: index)
                }
            case let .failure(_, code, description):
                fatalError("Unresolved error: code: \(code), \(description)")
            case .success:
                fatalError("success is not being processed!")
            }
        }
    }
    
    func eventCreate() {
        appState.itemStartMode = .create(completion: { [self, weak output] in
            guard let output = output else { return }
            output.presentAdded(model: presentationModelFromAppState(), index: appState.todoList.count - 1)
        })
        output.presentItem();
    }

    func eventItemSelected(index: Int) {
        appState.itemStartMode = .update(index: index, completion: { [self, weak output] in
            guard let output = output else { return }
            output.presentChanged(model: presentationModelFromAppState(), index: index)
        })
        output.presentItem();
    }

}
