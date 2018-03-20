//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayImpl: EntityGateway {
    let todoManager =  TodoManagerImpl() as TodoManager
}
