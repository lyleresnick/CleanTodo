//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemDisplayRowView: NibBasedView {
    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func show(model: TodoItemDisplayRowViewModel) {
        fieldNameLabel.text = model.fieldName
        valueLabel.text = model.value
    }
}
