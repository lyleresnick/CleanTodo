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

private enum TodoRootRouterSegue: String {
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
        
        let identifier = TodoRootRouterSegue.createTodo.rawValue
        let startMode: TodoStartMode = .create(completion: completion)
        viewControllers.first?.performSegue(withIdentifier: identifier, sender: startMode)
    }
    
    func showItem(id: String, completion: @escaping TodoListChangedItemCallback) {
        
        let identifier = TodoRootRouterSegue.showTodo.rawValue
        let startMode: TodoStartMode = .update(id: id, completion: completion)
        viewControllers.first?.performSegue(withIdentifier: identifier, sender: startMode)
    }
}

extension TodoListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewController = segue.destination as! TodoItemRouterViewController
        viewController.startMode = sender as! TodoStartMode
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







