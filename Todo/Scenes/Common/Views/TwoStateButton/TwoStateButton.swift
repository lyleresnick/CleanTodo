
//  Copyright © 2016 Lyle Resnick. All rights reserved.

import UIKit

protocol TwoStateButtonDelegate {
    func onTouched()
    func offTouched()
}

@IBDesignable
class TwoStateButton: UIButton {
    
    #if TARGET_INTERFACE_BUILDER
    var delegate: TwoStateButtonDelegate? {
        set { }
        get { return nil }
    }
    #else
    var delegate: TwoStateButtonDelegate?
    #endif

    private var offImage: UIImage!
    private var onImage: UIImage!
    private var isOn = false

    public override init(frame: CGRect = CGRect.zero ) {
        super.init(frame: frame)
        postInitSetUp()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInitSetUp()
    }

    fileprivate enum ImageName: String {
        case off = "icon-media-player-audio-mute"
        case on = "icon-media-player-audio-on"
    }

    private func postInitSetUp() {

        let bundle = Bundle(for:  type(of: self))
        offImage = UIImage(named: ImageName.off, in: bundle)
        onImage = UIImage(named: ImageName.on, in: bundle)
        
        addTarget(self, action: #selector(twoStateButtonTouched), for: .touchUpInside)
        reset()
    }

    @objc private func twoStateButtonTouched(_ sender: UIButton) {

        if !isOn {

            setImage(onImage, for: .normal)
            isOn = true
            delegate?.onTouched()
        }
        else {

            setImage(offImage, for: .normal)
            isOn = false
            delegate?.offTouched()
        }
    }

    func reset() {
        setImage(offImage, for: .normal)
        isOn = false

    }
}

private extension UIImage {

    convenience init?( named: TwoStateButton.ImageName, in bundle: Bundle? ) {
        self.init( named: named.rawValue, in: bundle, compatibleWith: nil)
    }
}