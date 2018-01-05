//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

enum  TodoErrorReason {
    case notFound
    case otherSemanticResult
}

protocol TodoManager {
    
    func all(parameter: String, completion: (ManagerResponse<[Todo], TodoErrorReason>) -> ())
}
