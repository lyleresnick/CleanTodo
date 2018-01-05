//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListConnector {

    private let viewController: TodoListViewController
    private let adapter: TodoListAdapter
    private let useCase: TodoListUseCase
    private let presenter: TodoListPresenter

    init(viewController: TodoListViewController, adapter: TodoListAdapter, useCase: TodoListUseCase, presenter: TodoListPresenter) {

        self.viewController = viewController
        self.adapter = adapter
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(viewController: TodoListViewController, adapter: TodoListAdapter, entityGateway: EntityGateway = EntityGatewayFactory.entityGateway) {

        let useCase = TodoListUseCase(entityGateway: entityGateway)
        let presenter = TodoListPresenter(useCase: useCase)

        self.init(viewController: viewController, adapter: adapter, useCase: useCase, presenter: presenter)
    }

    func configure() {
        viewController.presenter = presenter
        adapter.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
    }
}
