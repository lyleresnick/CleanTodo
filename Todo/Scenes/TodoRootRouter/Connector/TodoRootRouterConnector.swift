//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoRootRouterConnector {

    private let viewController: TodoRootRouterNavController
    private let presenter: TodoRootRouterPresenter

    init(viewController: TodoRootRouterNavController, presenter: TodoRootRouterPresenter) {

        self.viewController = viewController
        self.presenter = presenter
    }

    convenience init(viewController: TodoRootRouterNavController) {

        let presenter = TodoRootRouterPresenter()
        self.init(viewController: viewController, presenter: presenter)
    }

    func configure() {
        viewController.presenter = presenter
        presenter.output = viewController
    }
}
