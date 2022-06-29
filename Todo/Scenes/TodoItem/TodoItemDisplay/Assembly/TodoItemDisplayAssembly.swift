//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemDisplayAssembly {
    private let viewController: TodoItemDisplayViewController
    private let useCase: TodoItemDisplayUseCase
    private let presenter: TodoItemDisplayPresenter

    init(viewController: TodoItemDisplayViewController, useCase: TodoItemDisplayUseCase, presenter: TodoItemDisplayPresenter) {
        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(router: TodoItemDisplayRouter) {
        let useCase = TodoItemDisplayUseCase()
        let presenter = TodoItemDisplayPresenter(useCase: useCase, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(type: TodoItemDisplayViewController.self)
        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() -> TodoItemDisplayViewController {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
        return viewController
    }
}
