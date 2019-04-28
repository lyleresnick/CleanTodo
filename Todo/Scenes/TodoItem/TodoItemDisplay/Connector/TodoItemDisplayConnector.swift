//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemDisplayConnector {

    private let viewController: TodoItemDisplayViewController
    private let useCase: TodoItemDisplayUseCase
    private let presenter: TodoItemDisplayPresenter

    init(viewController: TodoItemDisplayViewController, useCase: TodoItemDisplayUseCase, presenter: TodoItemDisplayPresenter) {

        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(viewController: TodoItemDisplayViewController) {

        let useCase = TodoItemDisplayUseCase()
        let presenter = TodoItemDisplayPresenter(useCase: useCase)
        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
    }
}
