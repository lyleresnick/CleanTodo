//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

struct TodoItemDisplayRowViewModel {
    
    let fieldName: String
    let value: String

    init(field: String, value: String) {
        self.fieldName = field
        self.value = value
    }
}
