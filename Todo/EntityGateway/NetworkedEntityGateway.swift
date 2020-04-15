//  Copyright © 2020 Lyle Resnick. All rights reserved.

class NetworkedEntityGateway: EntityGateway {
    lazy var todoManager = NetworkedTodoManager() as TodoManager
}
