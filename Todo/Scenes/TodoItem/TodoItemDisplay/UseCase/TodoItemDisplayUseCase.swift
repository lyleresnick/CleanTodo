//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayUseCase {
    weak var output: TodoItemDisplayUseCaseOutput!
    private var appState: AppState

    init(appState: AppState = TodoAppState.instance ) {
        self.appState = appState;
    }

    func eventViewReady() {
        let todo = appState.currentTodo!
        var rows: [TodoItemDisplayRowPresentationModel] = []
        rows.append(.init(field: .title, value: .string(todo.title)))
        if todo.note != "" {
            rows.append(.init(field: .note, value: .string(todo.note)))
        }
        if let completeBy = todo.completeBy {
            rows.append(.init(field: .completeBy, value: .date( completeBy)))
        }
        switch todo.priority {
        case .none:
            break
        default:
            rows.append(.init(field: .priority, value: .priority(todo.priority)))
        }
        rows.append(.init(field: .completed, value: .bool(todo.completed)))
        output.present(model: TodoItemDisplayPresentationModel(rows: rows))
    }
}
