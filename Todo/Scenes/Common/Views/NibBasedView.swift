//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

class NibBasedView: UIView {
    @IBOutlet private(set) weak var view: UIView!

    public override init(frame: CGRect = CGRect.zero ) {
        super.init(frame: frame)
        postInitSetUp()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInitSetUp()
    }

    func postInitSetUp() {
        backgroundColor = .clear

        loadView()
        configureView()
        addSubview(view)
    }

    private func loadView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let _ = nib.instantiate(withOwner: self, options: nil)
    }

    func configureView() {
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
    }
}
