//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

protocol TodoItemDisplayPresenterOutput: class {
    
    func showBegin()
    func show(model: TodoItemDisplayRowViewModel)
    func showEnd()
}
