//  Copyright © 2019 Lyle Resnick. All rights reserved.

protocol UseCaseStore {
    subscript(_ key: String) -> AnyObject? { get set }
}
