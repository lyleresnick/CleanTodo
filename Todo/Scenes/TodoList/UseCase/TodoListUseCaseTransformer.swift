//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

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
                
                switch(reason) {
                case .notFound:
                    output.presentNotFound(message: "Hello")

                case .otherSemanticResult:
                    output.presentOtherSemanticResult()
                }
                
            case let .failure(code):

                switch code {
                case 400...499:
                    output.presentNetworkError(code: code)
                default:
                    output.presentUnknownError(code: code)
                    break
                }

            case let .success(entityList):
                
                output.presentModelListBegin()
                for entity in entityList {
                    output.present(model: TodoListPresentationModel(entity: entity))
                }
                output.presentModelListEnd()
            }
        }
    }
}
