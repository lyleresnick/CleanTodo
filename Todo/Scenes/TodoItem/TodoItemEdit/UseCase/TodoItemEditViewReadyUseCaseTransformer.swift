//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemEditViewReadyUseCaseTransformer {
    
    private let editMode: TodoItemEditMode
    private let cache: TodoItemRouterUseCaseCache
    
    init(editMode: TodoItemEditMode, cache: TodoItemRouterUseCaseCache) {
        self.editMode = editMode
        self.cache = cache
    }

    func transform(output: TodoItemEditUseCaseOutput) -> TodoItemEditUseCase.EditingTodo {
        
        switch editMode {
        case .update:
            output.present(model: TodoItemEditPresentationModel(entity: cache.currentTodo!))
            return TodoItemEditUseCase.EditingTodo(todo: cache.currentTodo!)
        case .create:
            output.presentNewModel()
            return TodoItemEditUseCase.EditingTodo()
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
