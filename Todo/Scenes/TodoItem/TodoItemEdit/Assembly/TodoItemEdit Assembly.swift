//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemEditAssembly {
    private let viewController: TodoItemEditViewController
    private let useCase: TodoItemEditUseCase
    private let presenter: TodoItemEditPresenter

    init(viewController: TodoItemEditViewController, useCase: TodoItemEditUseCase, presenter: TodoItemEditPresenter) {
        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(router: TodoItemEditRouter) {
        let useCase = TodoItemEditUseCase()
        let presenter = TodoItemEditPresenter(useCase: useCase, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(type: TodoItemEditViewController.self)
        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() -> TodoItemEditViewController {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
        return viewController
    }
}
