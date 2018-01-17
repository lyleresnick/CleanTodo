//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TodoManagerImpl: TodoManager {

    func all(completion: (ManagerResponse<[Todo], TodoErrorReason>) -> ()) {
            completion(.success(entity: todoData))
    }
    
    func done(id:String, done: Bool, completion: (ManagerResponse<Todo, TodoErrorReason>) -> ()) {
        
        for entity in todoData {
            if entity.id == id {
                
                entity.done = done
                completion(.success(entity: entity))
                return;
            }
        }
        completion(.failure(code: 404))
    }
}
