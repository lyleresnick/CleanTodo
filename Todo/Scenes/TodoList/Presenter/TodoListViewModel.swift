//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

struct TodoListViewModel {
    
    var name: String
    var age: String

    init( model: TodoListPresentationModel ) {
        name = model.name
        age = String(model.age)
    }
}
