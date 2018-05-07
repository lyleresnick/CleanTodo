//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListCompleteUseCaseTransformer: TodoListAbstractUseCaseTransformer {
    
    func transform(completed: Bool, index: Int, id: String, output: TodoListCompleteUseCaseOutput)  {
        
        todoManager.completed(id: id, completed: completed) { [weak output] result in

            guard let output = output else { return }

            switch result {
            case let .semanticError(reason):

               fatalError("semanticError \(reason) is not being processed!")
                
            case let .failure(error):

                fatalError("Unresolved error: \(error.description)")

            case let .success(entity):
                
                output.presentCompleted(model: TodoListPresentationModel(entity: entity), index: index)
            }
        }
    }
}
