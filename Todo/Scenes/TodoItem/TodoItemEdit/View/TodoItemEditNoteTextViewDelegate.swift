//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoItemEditNoteTextViewDelegate: NSObject, UITextViewDelegate {
    
    let presenter: TodoItemEditPresenter
    
    init(presenter: TodoItemEditPresenter) {
        self.presenter = presenter
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        presenter.eventEdited(note: textView.text!)
    }
}
