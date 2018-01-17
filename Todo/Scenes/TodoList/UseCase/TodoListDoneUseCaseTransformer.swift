//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListDoneUseCaseTransformer: TodoListAbstractUseCaseTransformer {
    
    func transform(done: Bool, at row: Int, id: String, output: TodoListUseCaseOutput)  {
        
        todoManager.done(id: id, done: done) { [weak output] result in

            guard let output = output else { return }

            switch result {
            case let .semanticError(reason):

               fatalError("semanticError \(reason) is not being processed!")
                
            case let .failure(code):

                fatalError("failure \(code) is not being processed!")

            case let .success(entity):
                
                output.presentChanged(model: TodoListPresentationModel(entity: entity), at: row)
            }
        }
    }
}
