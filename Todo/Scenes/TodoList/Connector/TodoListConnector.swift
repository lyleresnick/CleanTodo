//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListConnector {

    private let viewController: TodoListViewController
    private let useCase: TodoListUseCase
    private let presenter: TodoListPresenter

    init(viewController: TodoListViewController, useCase: TodoListUseCase, presenter: TodoListPresenter) {

        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(viewController: TodoListViewController) {

        let useCase = TodoListUseCase()
        let presenter = TodoListPresenter(useCase: useCase)

        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
    }
}
