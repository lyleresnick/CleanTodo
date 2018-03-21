//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayImpl: EntityGateway {
    lazy var todoManager = { TodoManagerImpl() as TodoManager }()
}
