//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
    
    enum Implementation {
        case test
        case coreData
    }
    
    static let gatewayImplementedVia = Implementation.coreData
    
    static var entityGateway: EntityGateway = {

        switch gatewayImplementedVia {
        case .test:
            return { EntityGatewayTestImpl() }()
        case .coreData:
            return { EntityGatewayCoreDataImpl(manager: CoreDataManager.shared) }()
        }
    } ()

}

