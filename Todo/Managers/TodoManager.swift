//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

enum  TodoErrorReason {
    case notFound
    case otherSemanticResult
}

protocol TodoManager {
    
    func all(completion: (ManagerResponse<[Todo], TodoErrorReason>) -> ())
}
