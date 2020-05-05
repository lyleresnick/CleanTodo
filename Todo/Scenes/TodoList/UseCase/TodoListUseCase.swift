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
            case let .domain(issue):
               fatalError("domain issue: \(issue) is not being processed!")
            case let .failure(_, description):
                fatalError("Unresolved error:\(description)")
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
            case let .domain(issue):
               fatalError("domain issue: \(issue) is not being processed!")
            case let .failure(_, description):
                fatalError("Unresolved error:\(description)")
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
            case let .domain(issue):
                switch(issue) {
                case .notFound:
                    fatalError("domain issue: \(issue) is not being processed!")
                case .noData:
                    appState.todoList.remove(at: index);
                    output.presentDeleted(model: presentationModelFromAppState(), index: index)
                }
            case let .failure(_, description):
                fatalError("Unresolved error:\(description)")
            case .success:
                fatalError("success is not being processed!")
            }
        }
    }
    
    private var completion:  () -> Void  { return { [self, weak output] in
        guard let output = output else { return }
        output.presentChanged(model: self.presentationModelFromAppState())
    }}
    
    func eventCreate() {
        appState.itemStartMode = .create(completion: completion)
        output.presentItem();
    }

    func eventItemSelected(index: Int) {
        appState.itemStartMode = .update(index: index, completion: completion)
        output.presentItem();
    }

}
