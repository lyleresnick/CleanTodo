//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemRouterAssembly {

    let viewController: TodoItemRouterViewController
    private let useCase: TodoItemRouterUseCase
    let presenter: TodoItemRouterPresenter

    init(viewController: TodoItemRouterViewController, useCase: TodoItemRouterUseCase, presenter: TodoItemRouterPresenter) {
        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(router: TodoItemRouterRouter) {
        let useCase = TodoItemRouterUseCase()
        let presenter = TodoItemRouterPresenter(useCase: useCase, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(type: TodoItemRouterViewController.self)
        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() -> TodoItemRouterViewController {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
        return viewController
    }
}
