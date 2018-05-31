//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemEditViewReadyUseCaseTransformer {
    
    private let editMode: TodoItemEditMode
    private let state: TodoItemUseCaseState
    
    init(editMode: TodoItemEditMode, state: TodoItemUseCaseState) {
        self.editMode = editMode
        self.state = state
    }

    func transform(output: TodoItemEditViewReadyUseCaseOutput) -> TodoItemEditUseCase.EditingTodo {
        
        switch editMode {
        case .update:
            output.present(model: TodoItemEditPresentationModel(entity: state.currentTodo!))
            return TodoItemEditUseCase.EditingTodo(todo: state.currentTodo!)
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
