//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoListDeleteUseCaseTransformer: TodoListAbstractUseCaseTransformer {
    
    func transform(index: Int, id: String, output: TodoListDeleteUseCaseOutput)  {
        
        todoManager.delete(id: id) { [weak output] result in
            
            guard let output = output else { return }
            
            switch result {
            case let .semantic(reason):
                switch(reason) {
                case .notFound:
                    fatalError("semantic event \(reason) is not being processed!")
                case .noData:
                    output.presentDeleted(index: index)
                }
            case let .failure(error):
                fatalError("Unresolved error: code: \(error.code), \(error.description)")
            case .success:
                fatalError("success is not being processed!")
            }
        }
    }
}

