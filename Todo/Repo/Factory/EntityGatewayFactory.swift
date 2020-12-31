//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
    
    enum Implementation {
        case test
        case coreData
        case networked
    }
    
    static let gatewayImplementation = Implementation.networked
    
    static var entityGateway: EntityGateway = {

        switch gatewayImplementation {
        case .test:
            return TestEntityGateway()
        case .coreData:
            return CoreDataEntityGateway(manager: CoreDataManager.shared)
        case .networked:
            return NetworkEntityGateway()
        }
    } ()

}

