//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCell: UITableViewCell {
    
    @IBOutlet private(set) weak var nameLabel: UILabel!
    @IBOutlet private(set) weak var ageLabel: UILabel!

    func show(viewModel: TodoListViewModel) -> Self {
        
        nameLabel.text = viewModel.name
        ageLabel.text = viewModel.age

        return self
    }
}
