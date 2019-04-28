//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemEditConnector {

    private let viewController: TodoItemEditViewController
    private let useCase: TodoItemEditUseCase
    private let presenter: TodoItemEditPresenter

    init(viewController: TodoItemEditViewController, useCase: TodoItemEditUseCase, presenter: TodoItemEditPresenter) {

        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(viewController: TodoItemEditViewController) {

        let useCase = TodoItemEditUseCase()
        let presenter = TodoItemEditPresenter(useCase: useCase)

        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
    }
}
