//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayCoreDataImpl: EntityGateway {
    
    let manager: CoreDataManager
    init(manager: CoreDataManager) {
        self.manager = manager
    }
    lazy var todoManager = { TodoManagerCoreDataImpl(manager: manager) as TodoManager }()
}
