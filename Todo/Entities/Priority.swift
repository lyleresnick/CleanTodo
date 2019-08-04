//  Copyright © 2019 Lyle Resnick. All rights reserved.

import Foundation

enum Priority: String {
    case high
    case medium
    case low
    case none
    
    var bangs: Int {
        get {
            switch self {
            case .high:
                return 3
            case .medium:
                return 2
            case .low:
                return 1
            case .none:
                return 0
            }
        }
    }
    
    init!(bangs: Int ) {
        
        var rawValue: String!
        switch bangs {
        case 3:
            rawValue = "high"
        case 2:
            rawValue = "medium"
        case 1:
            rawValue = "low"
        case 0:
            rawValue = "none"
        default:
            fatalError("bangs must be 0, 1, 2 or 3")
        }
        self.init(rawValue: rawValue)
    }
}
