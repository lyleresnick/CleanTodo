//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EntityGatewayTestImpl: EntityGateway {
    lazy var todoManager = { TodoManagerTestImpl() as TodoManager }()
}
