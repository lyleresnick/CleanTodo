
//  Copyright © 2016 Lyle Resnick. All rights reserved.

import UIKit

protocol TwoStateButtonDelegate {
    func onTouched()
    func offTouched()
}

@IBDesignable
class TwoStateButton: UIButton {

    var delegate: TwoStateButtonDelegate?

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

        offImage = UIImage(named: ImageName.off)
        onImage = UIImage(named: ImageName.on)
        addTarget(self, action: #selector(twoStateButtonTouched), for: .touchUpInside)
        reset()
    }

    @objc private func twoStateButtonTouched(_ sender: UIButton) {

        if !isOn {

            setImage(offImage, for: .normal)
            isOn = true
            delegate?.onTouched()
        }
        else {

            setImage(onImage, for: .normal)
            isOn = false
            delegate?.offTouched()
        }
    }

    func reset() {
        setImage(onImage, for: .normal)
        isOn = false

    }

}

private extension UIImage {

    convenience init?( named: TwoStateButton.ImageName ) {
        self.init( named: named.rawValue)
    }
}
