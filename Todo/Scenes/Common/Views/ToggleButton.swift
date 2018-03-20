//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

protocol ToggleButtonDelegate: class {
    func onTouched()
    func offTouched()
}

@IBDesignable
class ToggleButton: UIButton {
    
    #if TARGET_INTERFACE_BUILDER
    weak var delegate: TwoStateButtonDelegate? {
        set { }
        get { return nil }
    }
    #else
    weak var delegate: ToggleButtonDelegate?
    #endif

    @IBInspectable var offImage: UIImage! {
        didSet {
            if !isOn {
                setImage(offImage, for: .normal)
            }
        }
    }
    @IBInspectable var onImage: UIImage! {
        didSet {
            if isOn {
                setImage(onImage, for: .normal)
            }
        }
    }

    private var isOn = false

    public override init(frame: CGRect = CGRect.zero ) {
        super.init(frame: frame)
        postInitSetUp()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInitSetUp()
    }

    private func postInitSetUp() {
        
        addTarget(self, action: #selector(twoStateButtonTouched), for: .touchUpInside)
        super.setImage(offImage, for: .normal)
    }

    @objc private func twoStateButtonTouched(_ sender: UIButton) {

        if !isOn {

            super.setImage(onImage, for: .normal)
            isOn = true
            delegate?.onTouched()
        }
        else {

            super.setImage(offImage, for: .normal)
            isOn = false
            delegate?.offTouched()
        }
    }
    
    var on: Bool {
        get { return isOn }
        set {
            isOn = newValue
            if isOn {
                super.setImage(onImage, for: .normal)
            }
            else {
                super.setImage(offImage, for: .normal)
            }
        }
    }
    
    override func setImage(_ image: UIImage?, for state: UIControlState) { /* do nothing */ }
}
