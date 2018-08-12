//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
    
    enum Implementation {
        case test
        case coreData
    }
    
    static let gatewayImplementation = Implementation.test
    
    static var entityGateway: EntityGateway = {

        switch gatewayImplementation {
        case .test:
            return TestEntityGateway()
        case .coreData:
            return CoreDataEntityGateway(manager: CoreDataManager.shared)
        }
    } ()

}

