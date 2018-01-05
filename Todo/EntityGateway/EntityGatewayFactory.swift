//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.

class EntityGatewayFactory {
    static var entityGateway: EntityGateway = {
        return EntityGatewayImpl()
    }()

}

