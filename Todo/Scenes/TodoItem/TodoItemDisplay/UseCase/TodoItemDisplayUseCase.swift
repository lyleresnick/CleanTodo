//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayUseCase {
    
    weak var output: TodoItemDisplayUseCaseOutput!
    private var appState: AppState

    init(appState: AppState = TodoAppState.instance ) {
        self.appState = appState;
    }

    func eventViewReady() {

        let todo = appState.itemState.currentTodo!
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
