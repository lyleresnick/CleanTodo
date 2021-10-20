//  Copyright © 2019 Lyle Resnick. All rights reserved.

enum TodoItemStartMode {
    case create(completion: () -> ())
    case update(index: Int, completion: () -> ())
}
