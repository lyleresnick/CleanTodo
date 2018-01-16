//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCell: UITableViewCell {
    

    private(set) var index: Int!
    private(set) var presenter: TodoListPresenter!
    @IBOutlet private(set) weak var doneButton: TwoStateButton!
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var priorityLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!

    func show(viewModel: TodoListViewModel, index: Int, presenter: TodoListPresenter) -> Self {
        
        self.presenter = presenter
        self.index = index
        doneButton.delegate = self

        titleLabel.text = viewModel.title
        priorityLabel.text = viewModel.priority
        dateLabel.text = viewModel.date
        doneButton.on = viewModel.done

        return self
    }

}

extension TodoListCell: TwoStateButtonDelegate {
    func onTouched() {
        
        presenter.eventDone(index: index)
    }
    
    func offTouched() {
        presenter.eventUndone(index: index)
    }

}


