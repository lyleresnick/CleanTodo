//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

class TestEntityGateway: EntityGateway {
    lazy var todoManager = TestTodoManager() as TodoManager
}
