//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemRouterViewController: CurrentContainerViewController, SpinnerAttachable {
    var presenter: TodoItemRouterPresenter!
    @IBOutlet weak var messageLabel: UILabel!
    private var spinnerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinnerView = attachSpinner()
        presenter.eventViewReady()
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
            showEditView()
        case .update:
            showDisplayView()
        }
    }
    
    func showMessageView(message: String) {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            self.spinnerView.stopAnimating()
            self.configureShowMessage()
            self.messageLabel.text = message
            self.configure(navigationItem: self.createMessageNavigationItem())
        }
    }
    
    func showDisplayView() {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            let viewController = TodoItemDisplayAssembly(router: self.presenter).configure()
            self.showConfiguredViewController(viewController: viewController)
        }
    }
    
    func showEditView() {
        DispatchQueue.main.async { [ weak self] in
            guard let self = self else { return }
            let viewController = TodoItemEditAssembly(router: self.presenter).configure()
            self.showConfiguredViewController(viewController: viewController)
        }
    }
    
    private func createMessageNavigationItem() -> UINavigationItem {
        let navItem = UINavigationItem()
        navItem.title = "todo".localized
        return navItem
    }
    
    private func configureContainer() {
        messageLabel.isHidden = true
        containerView.isHidden = false
    }
    
    private func configureShowMessage() {
        messageLabel.isHidden = false
        containerView.isHidden = true
    }

    private func configure(navigationItem: UINavigationItem) {
        self.navigationItem.backBarButtonItem = navigationItem.backBarButtonItem
        self.navigationItem.leftBarButtonItems = navigationItem.leftBarButtonItems
        self.navigationItem.rightBarButtonItems = navigationItem.rightBarButtonItems
        self.navigationItem.title = navigationItem.title
    }
    
    private func showConfiguredViewController(viewController: UIViewController) {
        spinnerView.stopAnimating()
        configureContainer()
        configure(navigationItem: viewController.navigationItem)
        show(viewController: viewController, animated: true)
    }
}
