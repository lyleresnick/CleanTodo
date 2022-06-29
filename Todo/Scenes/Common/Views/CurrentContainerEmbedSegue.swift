//  Copyright © 2018 Lyle Resnick. All rights reserved.

import UIKit

@objc(CurrentContainerEmbedSegue)
class CurrentContainerEmbedSegue: UIStoryboardSegue {
    override func perform() {
        
        let sourceContainer = source as! CurrentContainerViewController
        sourceContainer.show(viewController: destination, animated: true)
    }
}

