//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoRouterAssembly {

    private let viewController: TodoRouterNavController
    private let presenter: TodoRouterPresenter

    init(viewController: TodoRouterNavController, presenter: TodoRouterPresenter) {
        self.viewController = viewController
        self.presenter = presenter
    }

    convenience init() {
        let presenter = TodoRouterPresenter()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(type: TodoRouterNavController.self)
        self.init(viewController: viewController, presenter: presenter)
    }

    func configure() -> TodoRouterNavController {
        viewController.presenter = presenter
        presenter.output = viewController
        return viewController
    }
}
