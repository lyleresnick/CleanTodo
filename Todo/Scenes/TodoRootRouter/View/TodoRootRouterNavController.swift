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

extension TodoRootRouterNavController: TodoRootRouterPresenterOutput {}

extension TodoRootRouterNavController: TodoRootRouterItemPresenterOutput {

    func showPop() {
        popViewController(animated: true)
    }
}

extension TodoRootRouterNavController: TodoRootRouterListPresenterOutput {
    
    func showCreateItem(completion: @escaping TodoListChangedItemCallback) {
        
        let firstViewController = viewControllers.first as! TodoListViewController
        firstViewController.prepareFor = { segue in
            let viewController = segue.destination as! TodoItemRouterViewController
            viewController.startMode = .create(completion: completion)
        }
        firstViewController.performSegue(identifier: TodoRootRouterSegue.createTodo)
    }
    
    func showItem(id: String, completion: @escaping TodoListChangedItemCallback) {
        
        let firstViewController = viewControllers.first as! TodoListViewController
        firstViewController.prepareFor = { segue in
            let viewController = segue.destination as! TodoItemRouterViewController
            viewController.startMode = .update(id: id, completion: completion)
        }
        firstViewController.performSegue(identifier: TodoRootRouterSegue.showTodo)
    }
}

extension TodoRootRouterNavController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
       
        switch viewController {
        case let viewController as TodoItemRouterViewController:
            viewController.router = presenter
        case let viewController as TodoListViewController:
            viewController.router = presenter
        default:
            fatalError("Unknown viewController encountered")
        }
    }
}







