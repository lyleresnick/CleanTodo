//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemRouterConnector {

    let viewController: TodoItemRouterViewController
    private let useCase: TodoItemRouterUseCase
    let presenter: TodoItemRouterPresenter


    init(viewController: TodoItemRouterViewController, useCase: TodoItemRouterUseCase, presenter: TodoItemRouterPresenter) {

        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(viewController: TodoItemRouterViewController) {

        let useCase = TodoItemRouterUseCase()
        let presenter = TodoItemRouterPresenter(useCase: useCase)
        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
    }
}

