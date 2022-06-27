//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemEditUseCase {
    
    weak var output: TodoItemEditUseCaseOutput!
    
    struct EditingTodo {
        
        var id: String?
        var title: String
        var note: String
        var completeBy: Date?
        var priority: Priority
        var completed: Bool
        
        init(id: String? = nil,
            title: String = "",
            note: String = "",
            completeBy: Date? = nil,
            priority: Priority = .none,
            completed: Bool = false) {
            
            self.id = id
            self.title = title
            self.note = note
            self.completeBy = completeBy
            self.priority = priority
            self.completed = completed
        }
    }
    
    private var editingTodo: EditingTodo!
    
    private let entityGateway: EntityGateway
    private var appState: AppState

    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway,
          appState: AppState = TodoAppState.instance ) {
        
        self.entityGateway = entityGateway
        self.appState = appState
        }
    
    // MARK: - Initialization

    func eventViewReady() {

        switch appState.itemStartMode! {
        case .update:
            output.present(model: TodoItemEditPresentationModel(entity: appState.currentTodo!))
            editingTodo = TodoItemEditUseCase.EditingTodo(todo: appState.currentTodo!)
        case .create:
            output.presentNewModel()
            editingTodo =  TodoItemEditUseCase.EditingTodo()
        }

    }

    // MARK: - Data Capture
    
    func eventEdited(title: String) {
        editingTodo.title = title
    }
    
    func eventEdited(note: String) {
        editingTodo.note = note
    }
    
    func eventCompleteByClear() {
        editingTodo.completeBy = nil
        output.presentCompleteByClear()
    }
    
    func eventCompleteByToday() {
        editingTodo.completeBy = Date()
        output.present(completeBy: editingTodo.completeBy)
    }
    
    func eventEnableEditCompleteBy() {
        output.presentEnableEdit(completeBy: editingTodo.completeBy)
    }

    func eventEdited(completeBy: Date) {
        editingTodo.completeBy = completeBy
        output.present(completeBy: completeBy)
    }
    
    func event(completed: Bool) {
        editingTodo.completed = completed
    }

    func eventEdited(priority: Priority ) {
        editingTodo.priority = priority

    }
    
    // MARK: - Finalization
    
    func eventCancel() {
        switch appState.itemStartMode! {
        case .update:
            output.presentEditItemCancelled()
        case .create:
            output.presentCreateItemCancelled()
        }
    }
    
    private typealias TodoManagerResponder = (Response<Todo,ItemIssue>) -> ()

    func eventSave() {
        
        guard editingTodo.title != "" else {
            output.presentTitleIsEmpty()
            return
        }
        
        let todoValues = TodoValues(editingTodo: editingTodo)
        output.presentLoading()
        switch appState.itemStartMode! {
        case let .create(completed):
            entityGateway.todoManager.create(values: todoValues) { [self, weak output] result in
                guard let output = output else { return }
                switch result {
                case let .domain(event):
                    fatalError("unexpected Semantic event: \(event)")
                case let .failure(_, description):
                    fatalError("Unresolved error: code: \(description)")
                case let .success(todo):
                    appState.currentTodo = todo
                    appState.todoList.append(todo);
                    completed();
                    output.presentSaveCompleted()
                }
            }
        case let .update(index, completed):
            entityGateway.todoManager.update( id: editingTodo.id!, values: todoValues) { [self, weak output] result in
                guard let output = output else { return }
                switch result {
                case let .domain(issue):
                    fatalError("unexpected Domain Issue: \(issue)")
                case let .failure(_, description):
                    fatalError("Unresolved error: code: \(description)")
                case let .success(todo):
                    appState.currentTodo = todo
                    appState.todoList[index] = todo;
                    completed();
                    output.presentSaveCompleted()
                }
            }
        }
    }
}

private extension TodoItemEditUseCase.EditingTodo {
    
    init(todo: Todo) {
        
        id = todo.id
        title = todo.title
        note = todo.note
        completeBy = todo.completeBy
        priority = todo.priority
        completed = todo.completed
    }
}


private extension TodoValues {
    
    init(editingTodo: TodoItemEditUseCase.EditingTodo) {
        
        title = editingTodo.title
        note = editingTodo.note
        completeBy = editingTodo.completeBy
        priority = editingTodo.priority
        completed = editingTodo.completed
    }
}
