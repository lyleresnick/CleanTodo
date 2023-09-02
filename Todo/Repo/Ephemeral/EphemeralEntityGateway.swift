//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class EphemeralEntityGateway: EntityGateway {
    lazy var todoManager = EphemeralTodoManager() as TodoManager
}
