//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

protocol ContainerViewController  {
    
    var containerView: UIView! { get }
    
    func add( contentController: UIViewController )
    func remove( contentController: UIViewController )
}

extension ContainerViewController where Self: UIViewController {
    
    func add( contentController: UIViewController ) {
        
        addChild( contentController )
        containerView.addSubview(contentController.view)
        contentController.view.frame = containerView.bounds
        contentController.didMove(toParent: self)
    }
    
    func remove( contentController: UIViewController ) {
        
        contentController.willMove(toParent: nil)
        contentController.view.removeFromSuperview()
        contentController.removeFromParent()
    }
}
