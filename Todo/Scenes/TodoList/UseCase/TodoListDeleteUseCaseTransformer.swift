//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListDeleteUseCaseTransformer: TodoListAbstractUseCaseTransformer {
    
    func transform(index: Int, id: String, output: TodoListUseCaseOutput)  {
        
        todoManager.delete(id: id) { [weak output] result in
            
            guard let output = output else { return }
            
            switch result {
            case let .semanticError(reason):
                
                fatalError("semanticError \(reason) is not being processed!")
                
            case let .failure(code):
                
                fatalError("failure \(code) is not being processed!")
                
            case .success(_):
                
                output.presentDeleted(index: index)
            }
        }
    }
}

