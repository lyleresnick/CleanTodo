//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemDisplayViewController: UIViewController {
    var presenter: TodoItemDisplayPresenter!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.eventViewReady()
    }
    
    @IBAction func editTouched(_ sender: UIBarButtonItem) {
        presenter.eventModeEdit()
    }
}

extension TodoItemDisplayViewController: TodoItemDisplayPresenterOutput {
    func show(model: TodoItemDisplayViewModel) {
        DispatchQueue.main.async {
            model.rows.forEach { row in
                let rowView = TodoItemDisplayRowView()
                rowView.show(model: row)
                self.stackView.addArrangedSubview(rowView)
            }
            self.stackView.addArrangedSubview(UIView())
        }
    }
}
