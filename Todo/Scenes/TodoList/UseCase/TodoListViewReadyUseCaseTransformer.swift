//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListViewReadyUseCaseTransformer: TodoListAbstractUseCaseTransformer {

    func transform(output: TodoListUseCaseOutput)  {
        
        todoManager.all() { [weak output] result in

            guard let output = output else { return }

            switch result {
            case let .semanticError(reason):

               fatalError("semanticError \(reason) is not being processed!")
                
            case let .failure(code):

                fatalError("failure \(code) is not being processed!")

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
