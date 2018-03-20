//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

class CurrentContainerViewController: UIViewController, ContainerViewController  {
    
    @IBOutlet private(set) weak var containerView: UIView!
    
    private let duration = 0.55
    private var currentViewController: UIViewController?
    
    func show(viewController: UIViewController, animated: Bool) {
        
        if animated {
            showAnimated(viewController: viewController)
        }
        else {
            show(viewController: viewController)
        }
    }

    private func showAnimated(viewController: UIViewController) {
        
        if let currentViewController = currentViewController {
            
            viewController.view.alpha = 0.0
            add(contentController: viewController)
            
            UIView.animate(withDuration: duration, animations: {
                viewController.view.alpha = 1.0
                currentViewController.view.alpha = 0.0
            },
            completion: { finished in
                self.remove(contentController: currentViewController)
            })
        }
        else {
            add(contentController: viewController)
        }
        currentViewController = viewController
    }
    
    private func show(viewController: UIViewController) {
        
        add(contentController: viewController)
        if let currentViewController = currentViewController {
            remove(contentController: currentViewController)
        }
        currentViewController = viewController
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any? = nil) {
        
        let _ = segue as! CurrentContainerEmbedSegue
    }

    override var shouldAutorotate: Bool {
        return currentViewController?.shouldAutorotate ?? true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return currentViewController?.supportedInterfaceOrientations ?? .allButUpsideDown
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentViewController?.preferredStatusBarStyle ?? .default
    }
}
