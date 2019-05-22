//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemEditSaveUseCaseTransformer {
    
    private let editMode: TodoItemEditMode
    private let todoManager: TodoManager
    private let state: TodoItemUseCaseState

    init(editMode: TodoItemEditMode, todoManager: TodoManager, state: TodoItemUseCaseState) {
        self.editMode = editMode
        self.todoManager = todoManager
        self.state = state
    }
    
    private typealias TodoManagerResponder = (TodoItemManagerResponse) -> ()
    
    func transform(editingTodo: TodoItemEditUseCase.EditingTodo, output: TodoItemEditSaveUseCaseOutput) {
        
        let completion: TodoManagerResponder = {
            [weak output] result in
            
            guard let output = output else { return }
            
            switch result {
            case let .semanticError(reason):
                fatalError("unexpected Semantic error: reason \(reason)")
            case let .failure(error):
                fatalError("Unresolved error: \(error.description)")
            case let .success(todo):
                self.state.currentTodo = todo
                self.state.itemChanged = true
                output.presentSaveCompleted()
            }
        }
            
        if editingTodo.title != "" {
            switch self.editMode {
            case .create:
                create(editingTodo: editingTodo, completion: completion)
            case .update:
                update(editingTodo: editingTodo, completion: completion)
            }
        }
        else {
            output.presentTitleIsEmpty()
        }
    }
    
    private func create(editingTodo: TodoItemEditUseCase.EditingTodo, completion: @escaping TodoManagerResponder) {
        todoManager.create(
            values: TodoValues(editingTodo: editingTodo),
            completion: completion)
    }

    private func update(editingTodo: TodoItemEditUseCase.EditingTodo, completion: @escaping TodoManagerResponder) {
        todoManager.update(
            id: editingTodo.id!,
            values: TodoValues(editingTodo: editingTodo),
            completion: completion)
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

