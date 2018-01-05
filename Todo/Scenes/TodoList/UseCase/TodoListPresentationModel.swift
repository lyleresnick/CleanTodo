//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

struct TodoListPresentationModel {

    var name: String
    var age: Int

    init( entity: Todo ) {
        name = entity.name
        age = entity.age
    }
}
