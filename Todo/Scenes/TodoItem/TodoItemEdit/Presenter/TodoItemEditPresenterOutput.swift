//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemEditPresenterOutput: AnyObject {
    func showLoading()
    func show(model: TodoItemEditViewModel, titlePlaceholder: String, priorityLabels: [String])
    func show(completeByAsString: String)
    func showAlert(alertTitle: String, message: String, actionTitle: String)
}
