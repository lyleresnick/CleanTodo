//  Copyright © 2017 lifetales.me. All rights reserved.

import UIKit

class DatePickerView: UIView {
    
    @IBOutlet weak var datePicker: UIDatePicker!

    var date: Date? {
        set {
            datePicker.setDate(date ?? Date(), animated: false)
        }
        get {
            return datePicker.date
        }
    }
}
