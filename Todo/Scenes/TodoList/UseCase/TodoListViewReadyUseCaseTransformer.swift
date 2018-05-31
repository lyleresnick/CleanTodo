//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListViewReadyUseCaseTransformer: TodoListAbstractUseCaseTransformer {

    func transform(output: TodoListViewReadyUseCaseOutput)  {
        
        todoManager.all() { [weak output] result in

            guard let output = output else { return }

            switch result {
            case let .semanticError(reason):

               fatalError("semanticError \(reason) is not being processed!")
                
            case let .failure(error):

                fatalError("Unresolved error: \(error.description)")

            case let .success(entityList):
                
                output.presentTodoListBegin()
                for entity in entityList {
                    output.present(model: TodoListPresentationModel(entity: entity))
                }
                output.presentTodoListEnd()
            }
        }
    }
}
