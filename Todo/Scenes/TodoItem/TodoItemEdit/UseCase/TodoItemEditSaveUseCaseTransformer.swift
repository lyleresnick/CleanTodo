//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemEditSaveUseCaseTransformer {
    
    private let editMode: TodoItemEditMode
    private let todoManager: TodoManager
    private let cache: TodoItemRouterUseCaseCache

    init(editMode: TodoItemEditMode, todoManager: TodoManager, cache: TodoItemRouterUseCaseCache) {
        self.editMode = editMode
        self.todoManager = todoManager
        self.cache = cache
    }
    
    private typealias TodoManagerResponse = (ManagerResponse<Todo, TodoErrorReason>) -> ()
    
    func transform(editingTodo: TodoItemEditUseCase.EditingTodo, output: TodoItemEditUseCaseOutput) {
        
        let completion: TodoManagerResponse = {
            [weak output] result in
            
            guard let output = output else { return }
            
            switch result {
            case let .semanticError(reason):
                fatalError("unexpected Semantic error: reason \(reason)")
            case let .failure(code):
                fatalError("unexpected Failure: code \(code)")
            case let .success(todo):
                
                self.cache.currentTodo = todo
                self.cache.itemChanged = true
                
                output.presentDisplayView()
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
    
    private func create(editingTodo: TodoItemEditUseCase.EditingTodo, completion: TodoManagerResponse) {
        todoManager.create(
            values: TodoValues(editingTodo: editingTodo),
            completion: completion)
    }

    private func update(editingTodo: TodoItemEditUseCase.EditingTodo, completion: TodoManagerResponse) {
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

