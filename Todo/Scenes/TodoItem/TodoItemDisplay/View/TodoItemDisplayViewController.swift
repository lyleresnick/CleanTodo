//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemDisplayViewController: UIViewController {
    
    var presenter: TodoItemDisplayPresenter!
    
    weak var router: TodoItemDisplayRouter! {
        set {
            presenter.router = newValue
        }
        get {
            return presenter.router
        }
    }

    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        TodoItemDisplayConnector(viewController: self).configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.eventViewReady()
    }
    
    @IBAction func editTouched(_ sender: UIBarButtonItem) {
        presenter.eventModeEdit()
    }
}

extension TodoItemDisplayViewController: TodoItemDisplayPresenterOutput {
    
    func showBegin() {
    }
    
    func show(model: TodoItemDisplayRowViewModel) {
        
        DispatchQueue.main.async {
            
            let row = TodoItemDisplayRowView()
            row.show(model: model)
            self.stackView.addArrangedSubview(row)
        }
    }
    
    func showEnd() {
        
        DispatchQueue.main.async {
            self.stackView.addArrangedSubview(UIView())
        }
    }
}





