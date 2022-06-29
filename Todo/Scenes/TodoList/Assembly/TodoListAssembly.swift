//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListAssembly {
    private let viewController: TodoListViewController
    private let useCase: TodoListUseCase
    private let presenter: TodoListPresenter

    init(viewController: TodoListViewController, useCase: TodoListUseCase, presenter: TodoListPresenter) {
        self.viewController = viewController
        self.useCase = useCase
        self.presenter = presenter
    }

    convenience init(router: TodoListRouter) {
        let useCase = TodoListUseCase()
        let presenter = TodoListPresenter(useCase: useCase, router: router)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(type: TodoListViewController.self)

        self.init(viewController: viewController, useCase: useCase, presenter: presenter)
    }

    func configure() -> TodoListViewController {
        viewController.presenter = presenter
        useCase.output = presenter
        presenter.output = viewController
        return viewController
    }
    
}
