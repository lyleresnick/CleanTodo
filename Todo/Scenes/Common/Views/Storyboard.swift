//  Copyright © 2022 Lyle Resnick. All rights reserved.
import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(type: T.Type) -> T {
        return instantiateViewController(
            withIdentifier: String(
                describing: T.self)) as! T
    }
}
