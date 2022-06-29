//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCell: UITableViewCell {
    weak var tableView: UITableView!
    var presenter: TodoListPresenter!
    
    @IBOutlet private(set) weak var completedButton: ToggleButton!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var priorityLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!

    func show(viewModel: TodoListRowViewModel) -> Self {
        
        completedButton.delegate = self

        titleLabel.text = viewModel.title
        priorityLabel.text = viewModel.priority
        dateLabel.text = viewModel.completeBy
        completedButton.on = viewModel.completed

        return self
    }
}

extension TodoListCell: ToggleButtonDelegate {
    func onTouched() {
        presenter.eventCompleted(index: tableView.indexPath(for: self)!.row)
    }
    
    func offTouched() {
        presenter.eventNotCompleted(index: tableView.indexPath(for: self)!.row)
    }
}


