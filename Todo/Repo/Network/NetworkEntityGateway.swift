//  Copyright © 2020 Lyle Resnick. All rights reserved.

class NetworkEntityGateway: EntityGateway {
    lazy var todoManager = NetworkTodoManager(apiClient: NetworkApiClient()) as TodoManager
}
