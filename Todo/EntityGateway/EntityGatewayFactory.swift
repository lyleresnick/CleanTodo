//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
   // static var entityGateway = { EntityGatewayImpl() }()
    
    static var entityGateway = { EntityGatewayCoreDataImpl(manager: CoreDataManager.shared) }()
    
}

