//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

protocol TodoItemRouterUseCaseOutput: AnyObject {
    func presentLoading()
    func presentTitle()
    func presentDisplayView()
    func presentEditView()
    func presentNotFound(id: String)
}

