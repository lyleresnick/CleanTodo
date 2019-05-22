//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayViewReadyUseCaseTransformer {
    
    private let state: TodoItemUseCaseState

    init(state: TodoItemUseCaseState) {
        self.state = state
    }

    func transform(output: TodoItemDisplayUseCaseOutput  )  {
        
        let todo = state.currentTodo!
        output.presentBegin()
        
        output.present(field: .title, value: todo.title)
        if todo.note != "" {
            output.present(field: .note, value: todo.note)
        }
        if let completeBy = todo.completeBy {
            output.present(field: .completeBy, value: completeBy)
        }
        switch todo.priority {
        case .none:
            break
        default:
            output.present(field: .priority, value: todo.priority)
        }
        output.present(field: .completed, value: todo.completed)
        output.presentEnd()
    }
}
