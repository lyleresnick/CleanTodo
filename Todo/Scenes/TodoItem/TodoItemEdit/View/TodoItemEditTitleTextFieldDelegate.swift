//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit


class TodoItemEditTitleTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    let presenter: TodoItemEditPresenter
    
    init(presenter: TodoItemEditPresenter) {
        self.presenter = presenter
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        presenter.eventEdited(title: textField.text!)
    }
}
