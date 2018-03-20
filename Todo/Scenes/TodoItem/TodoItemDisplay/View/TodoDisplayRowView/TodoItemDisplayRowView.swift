
import UIKit


class TodoItemDisplayRowView: NibBasedView {
    
    @IBOutlet weak var fieldNameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func show(model: TodoItemDisplayRowViewModel) {
        
        fieldNameLabel.text = model.fieldName
        valueLabel.text = model.value
    }
}
