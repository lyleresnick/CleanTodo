//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

class BackingInputViewLabel: UILabel {
    
    private var backingInputView: UIView?

    override var inputView: UIView? {
        get {
            return backingInputView
        }
        set {
            backingInputView = newValue
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
}
