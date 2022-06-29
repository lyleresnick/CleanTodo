//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoRouterNavController:  UINavigationController  {
    var presenter: TodoRouterPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.eventViewReady()
    }
}

extension TodoRouterNavController: TodoRouterPresenterOutput {
    func showReady() {
        setViewControllers([TodoListAssembly(router: self.presenter).configure()], animated: true)
    }
    
    func showPop() {
        popViewController(animated: true)
    }
    
    func showItem() {
        pushViewController(TodoItemRouterAssembly(router: self.presenter).configure(), animated: true)
    }
}





