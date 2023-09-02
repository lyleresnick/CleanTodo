//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
    
    enum Implementation {
        case ephemeral
        case coreData
        case networked
    }
    
    static let gatewayImplementation = Implementation.ephemeral
    
    static var entityGateway: EntityGateway = {

        switch gatewayImplementation {
        case .ephemeral:
            return EphemeralEntityGateway()
        case .coreData:
            return CoreDataEntityGateway(manager: CoreDataManager.shared)
        case .networked:
            return NetworkEntityGateway()
        }
    } ()

}

