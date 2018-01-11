//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoManagerImpl: TodoManager {
    
    func all(completion: (ManagerResponse<[Todo], TodoErrorReason>) -> ()) {
            completion(.success(entity: todoData))
    }
}
