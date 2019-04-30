
//  Copyright © 2019 Lyle Resnick. All rights reserved.

class RealUseCaseStore: UseCaseStore {
    
    static let store = RealUseCaseStore()
    
    private var data = [String: AnyObject]()
    
    private init() { }
    
    subscript(_ key: String) -> AnyObject? {
        get {
            return data[key]
        }
        set(newValue) {
            data[key] = newValue
        }
    }
}
