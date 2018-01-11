//  Copyright (c) 2018 Lyle Resnick. All rights reserved.
import Foundation

class TodoListUseCaseTransformer {
    
    private let modelManager: TodoManager

    init(modelManager:  TodoManager) {
        self.modelManager = modelManager
    }

    func transform( parameter: String, output: TodoListUseCaseOutput  )  {
        
        modelManager.all(parameter: parameter) { [weak output] result in

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
