//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayFactory {
    static var entityGateway: EntityGateway = {
        return EntityGatewayImpl()
    }()

}

