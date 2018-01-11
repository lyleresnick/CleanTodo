//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCell: UITableViewCell {
    
    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var priorityLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!

    func show(viewModel: TodoListViewModel) -> Self {
        
        titleLabel.text = viewModel.title
        priorityLabel.text = viewModel.priority
        dateLabel.text = viewModel.date

        return self
    }
}
