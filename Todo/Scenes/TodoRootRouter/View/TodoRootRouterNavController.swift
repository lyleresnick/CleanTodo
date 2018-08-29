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
        
        performSegue(identifier: .createTodo, startMode: .create(completion: completion))
    }
    
    func showItem(id: String, completion: @escaping TodoListChangedItemCallback) {
        
        performSegue(identifier: .showTodo, startMode: .update(id: id, completion: completion))
    }
    
    private func performSegue(identifier: TodoRootRouterSegue, startMode: TodoStartMode) {
        
        let listViewController = viewControllers.first as! TodoListViewController
        listViewController.prepareFor = { segue in
            let viewController = segue.destination as! TodoItemRouterViewController
            viewController.startMode = startMode
        }
        listViewController.performSegue(identifier: identifier)
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







