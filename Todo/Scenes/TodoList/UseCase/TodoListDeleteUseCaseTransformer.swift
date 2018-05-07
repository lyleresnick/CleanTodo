//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListDeleteUseCaseTransformer: TodoListAbstractUseCaseTransformer {
    
    func transform(index: Int, id: String, output: TodoListDeleteUseCaseOutput)  {
        
        todoManager.delete(id: id) { [weak output] result in
            
            guard let output = output else { return }
            
            switch result {
            case let .semanticError(reason):
                
                fatalError("semanticError \(reason) is not being processed!")
                
            case let .failure(error):
                
                fatalError("Unresolved error: \(error.description)")

            case .success(_):
                
                output.presentDeleted(index: index)
            }
        }
    }
}

