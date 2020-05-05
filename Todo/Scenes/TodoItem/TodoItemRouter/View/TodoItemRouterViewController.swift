//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemRouterViewController: CurrentContainerViewController {

    var presenter: TodoItemRouterPresenter!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TodoItemRouterConnector(viewController: self).configure()
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
            viewController.presenter.router = presenter
            show(navigationItem: viewController.navigationItem)
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
        DispatchQueue.main.async {
            self.title = title
        }
    }
    
    func showViewReady(startMode: TodoItemStartMode) {
        
        switch startMode {
        case .create:
            showCreateView()
        case .update:
            showDisplayView()
        }
    }
    
    private func showCreateView() {
        
        DispatchQueue.main.async {
            self.configureMessage(hidden: true)
            self.performSegue(withIdentifier: Segue.showEditView.rawValue, sender: TodoItemEditMode.create)
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

    func showDisplayView() {
        DispatchQueue.main.async {
            self.configureMessage(hidden: true)
            self.performSegue(withIdentifier: Segue.showDisplayView.rawValue, sender: nil)
        }
    }
    
    func showEditView() {
        DispatchQueue.main.async {
            self.configureMessage(hidden: true)
            self.performSegue(withIdentifier: Segue.showEditView.rawValue, sender: nil)
        }
    }
}
