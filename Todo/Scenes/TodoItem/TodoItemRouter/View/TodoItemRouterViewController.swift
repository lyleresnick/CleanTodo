//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

enum TodoStartMode {
    case create(completion: TodoListChangedItemCallback)
    case update(id: String, completion: TodoListChangedItemCallback)
}

class TodoItemRouterViewController: CurrentContainerViewController {

    var presenter: TodoItemRouterPresenter!

    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        TodoItemRouterConnector(viewController: self).configure()

    }
    
    weak var router: TodoItemRouterRouter! {
        set {
            presenter.router = newValue
        }
        get {
            return presenter.router
        }
    }
    
    var startMode: TodoStartMode! {
        set {
            presenter.startMode = newValue
        }
        get {
            return presenter.startMode
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.eventViewReady()
    }

    private enum Segue: String {
        case showDisplayView
        case showEditView
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any? = nil) {

        super.prepare(for: segue, sender: sender)
        
        switch Segue(rawValue: segue.identifier!)! {
        case .showDisplayView:

            let viewController = segue.destination as! TodoItemDisplayViewController
            viewController.presenter.router = presenter
            show(navigationItem: viewController.navigationItem)

        case .showEditView:
            
            let viewController = segue.destination as! TodoItemEditViewController
            viewController.editMode = sender as! TodoItemEditMode
            viewController.presenter.router = presenter
            show(navigationItem: viewController.navigationItem)
        }
    }

    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController:parent)
        if parent == nil {
            presenter.eventBack()

        }
    }
    
    private func show(navigationItem: UINavigationItem) {
        
        self.navigationItem.backBarButtonItem = navigationItem.backBarButtonItem
        self.navigationItem.leftBarButtonItems = navigationItem.leftBarButtonItems
        self.navigationItem.rightBarButtonItems = navigationItem.rightBarButtonItems
        self.navigationItem.title = navigationItem.title
    }
}

extension TodoItemRouterViewController: TodoItemRouterPresenterOutput {
    
    func show(title: String) {
        self.title = title
    }
    
    func showViewReady(startMode: TodoStartMode) {
        
        switch startMode {
        case .create:
            showCreateView()
        case .update(_):
            showDisplayView()
        }
    }
    
    func showDisplayView() {

        DispatchQueue.main.async {
            
            self.configureMessage(hidden: true)
            self.performSegue(withIdentifier: Segue.showDisplayView.rawValue, sender: nil)
        }
    }
    
    func showCreateView() {
        
        DispatchQueue.main.async {
            
            self.configureMessage(hidden: true)
            self.performSegue(withIdentifier: Segue.showEditView.rawValue, sender: TodoItemEditMode.create)
        }
    }
    
    func showEditView() {
        
        DispatchQueue.main.async {
            
            self.configureMessage(hidden: true)
            self.performSegue(withIdentifier: Segue.showEditView.rawValue, sender: TodoItemEditMode.update)
        }
    }

    func showView(message: String) {
        
        DispatchQueue.main.async {
            
            self.show(navigationItem: self.createMessageNavigationItem())
            self.configureMessage(hidden: false)
            self.messageLabel.text = message
        }
    }
    
    private func createMessageNavigationItem() -> UINavigationItem {
        
        let navItem = UINavigationItem()
        navItem.title = "todo".localized
        return navItem
    }

    private func configureMessage(hidden: Bool) {
        
        messageLabel.isHidden = hidden
        containerView.isHidden = !hidden
    }
}



