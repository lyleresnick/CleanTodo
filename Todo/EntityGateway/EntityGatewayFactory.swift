//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
    
    enum Implementation {
        case test
        case coreData
    }
    
    static let gatewayImplementation = Implementation.coreData
    
    static var entityGateway: EntityGateway = {

        switch gatewayImplementation {
        case .test:
            return { EntityGatewayTestImpl() }()
        case .coreData:
            return { EntityGatewayCoreDataImpl(manager: CoreDataManager.shared) }()
        }
    } ()

}

