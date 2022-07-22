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
        output.presentLoading()
        entityGateway.todoManager.all() { [self, weak output] result in
            guard let output = output else { return }
            switch result {
            case let .domain(issue):
               fatalError("domain issue: \(issue) is not being processed!")
            case let .failure(description):
                fatalError("Unresolved error:\(description)")
            case let .success(todoList):
                appState.todoList = todoList;
                output.present(model: TodoListPresentationModel(todoList: appState.todoList))
            case let .networkIssue(issue):
                fatalError("Unresolved network error: \(issue)")
            }
        }
    }
    
    func event(completed: Bool, index: Int) {
        let id = appState.todoList[index].id
        output.presentLoading()
        entityGateway.todoManager.completed(id: id, completed: completed) { [self, weak output] result in
            guard let output = output else { return }
            switch result {
            case let .domain(issue):
               fatalError("domain issue: \(issue) is not being processed!")
            case let .failure(description):
                fatalError("Unresolved error:\(description)")
            case let .success(entity):
                appState.todoList[index] = entity;
                output.presentCompleted(model: TodoListPresentationModel(todoList: appState.todoList), index: index)
            case let .networkIssue(issue):
                fatalError("Unresolved network error:\(issue)")
            }
        }
    }
    
    func eventDelete(index: Int) {
        let id = appState.todoList[index].id
        output.presentLoading()
        entityGateway.todoManager.delete(id: id) { [self, weak output] result in
            guard let output = output else { return }
            switch result {
            case let .domain(issue):
                switch(issue) {
                case .notFound:
                    fatalError("domain issue: \(issue) is not being processed!")
                case .noData:
                    appState.todoList.remove(at: index);
                    output.presentDeleted(model: TodoListPresentationModel(todoList: appState.todoList), index: index)
                }
            case let .failure(description):
                fatalError("Unresolved error:\(description)")
            case .success:
                fatalError("success is not being processed!")
            case let .networkIssue(issue):
                fatalError("Unresolved network error:\(issue)")
            }
        }
    }
    
    private var completion:  () -> Void  { return { [weak self, weak output] in
        guard let output = output, let self = self else { return }
        output.presentChanged(model: TodoListPresentationModel(todoList: self.appState.todoList))
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
