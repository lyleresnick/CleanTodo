//  Copyright © 2017 Lyle Resnick. All rights reserved.

import UIKit

class DatePickerView: UIView {
    @IBOutlet weak var datePicker: UIDatePicker!

    var date: Date? {
        set {
            datePicker.setDate(newValue ?? Date(), animated: false)
        }
        get {
            return datePicker.date
        }
    }
}
