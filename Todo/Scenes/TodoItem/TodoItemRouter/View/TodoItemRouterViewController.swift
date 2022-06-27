//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemRouterViewController: CurrentContainerViewController, SpinnerAttachable {

    var presenter: TodoItemRouterPresenter!
    @IBOutlet weak var messageLabel: UILabel!
    private var spinnerView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        TodoItemRouterConnector(viewController: self).configure()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = attachSpinner()
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
    func showLoading() {
        DispatchQueue.main.async { [ weak self] in
            self?.spinnerView.startAnimating()
        }
    }
    
    func show(title: String) {
        DispatchQueue.main.async { [ weak self] in
            self?.title = title
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
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            self.configure(messageHidden: true)
            self.performSegue(withIdentifier: Segue.showEditView.rawValue, sender: TodoItemEditMode.create)
        }
    }
    
    func showView(message: String) {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            self.configure(messageHidden: false)
            self.messageLabel.text = message
            self.show(navigationItem: self.createMessageNavigationItem())
        }
    }
    
    private func createMessageNavigationItem() -> UINavigationItem {
        let navItem = UINavigationItem()
        navItem.title = "todo".localized
        return navItem
    }
    
    private func configure(messageHidden: Bool) {
        spinnerView.stopAnimating()
        messageLabel.isHidden = messageHidden
        containerView.isHidden = !messageHidden
    }

    func showDisplayView() {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            self.configure(messageHidden: true)
            self.performSegue(withIdentifier: Segue.showDisplayView.rawValue, sender: nil)
        }
    }
    
    func showEditView() {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            self.configure(messageHidden: true)
            self.performSegue(withIdentifier: Segue.showEditView.rawValue, sender: nil)
        }
    }
}
