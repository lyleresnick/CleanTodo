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
            output.present(model: TodoItemEditPresentationModel(entity: appState.itemState.currentTodo!))
            editingTodo = TodoItemEditUseCase.EditingTodo(todo: appState.itemState.currentTodo!)
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
    
    private typealias TodoManagerResponder = (TodoItemManagerResponse) -> ()

    func eventSave() {
        
        guard editingTodo.title != "" else {
            output.presentTitleIsEmpty()
            return
        }
        
        let completion: TodoManagerResponder = {
            [self, weak output] result in
            
            guard let output = output else { return }
            
            switch result {
            case let .semantic(event):
                fatalError("unexpected Semantic event: \(event)")
            case let .failure(_, code, description):
                fatalError("Unresolved error: code: \(code), \(description)")
            case let .success(todo):
                appState.itemState.currentTodo = todo
                appState.itemState.itemChanged = true
                
                switch appState.itemStartMode! {
                case .create:
                    appState.todoList.append(todo);

                case .update(let index, _):
                    appState.todoList[index] = todo;
                }
                output.presentSaveCompleted()
            }
        }
        let todoValues = TodoValues(editingTodo: editingTodo)
        switch appState.itemStartMode! {
        case .create:
            entityGateway.todoManager.create(
                values: todoValues,
                completion: completion)
        case .update:
            entityGateway.todoManager.update(
                id: editingTodo.id!,
                values: todoValues,
                completion: completion)
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
