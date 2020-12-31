//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class CoreDataEntityGateway: EntityGateway {
    let manager: CoreDataManager
    
    init(manager: CoreDataManager) {
        self.manager = manager
    }
    lazy var todoManager = CoreDataTodoManager(manager: manager) as TodoManager
}
