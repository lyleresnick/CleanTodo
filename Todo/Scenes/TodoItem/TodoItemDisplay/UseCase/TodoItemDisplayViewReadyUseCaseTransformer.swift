//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoItemDisplayViewReadyUseCaseTransformer {
    
    private let cache: TodoItemRouterUseCaseCache

    init(cache: TodoItemRouterUseCaseCache) {
        self.cache = cache
    }

    func transform(output: TodoItemDisplayUseCaseOutput  )  {
        
        let todo = cache.currentTodo!
        output.presentBegin()
        
        output.present(field: .title, value: todo.title)
        if todo.note != "" {
            output.present(field: .note, value: todo.note)
        }
        if let completeBy = todo.completeBy {
            output.present(field: .completeBy, value: completeBy)
        }
        if let priority = todo.priority {
            output.present(field: .priority, value: priority)
        }
        output.present(field: .completed, value: todo.completed)

        output.presentEnd()
    }
}
