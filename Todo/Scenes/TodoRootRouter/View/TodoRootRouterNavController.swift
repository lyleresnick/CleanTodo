//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoRootRouterNavController:  UINavigationController  {
    
    var presenter: TodoRootRouterPresenter!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        TodoRootRouterConnector(viewController: self).configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

enum TodoRootRouterSegue: String, Segue {
    case createTodo
    case showTodo
}

extension TodoRootRouterNavController: TodoRootRouterPresenterOutput {

    func showPop() {
        popViewController(animated: true)
    }
    
    func showItem() {
        performSegue(identifier: .showTodo)
    }
    
    private func performSegue(identifier: TodoRootRouterSegue) {
        
        let listViewController = viewControllers.first as! TodoListViewController
        listViewController.performSegue(identifier: identifier)
    }
}

extension TodoRootRouterNavController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       
        switch viewController {
        case let viewController as TodoItemRouterViewController:
            viewController.presenter.router = presenter
        case let viewController as TodoListViewController:
            viewController.presenter.router = presenter
        default:
            fatalError("Unknown viewController encountered")
        }
    }
}







