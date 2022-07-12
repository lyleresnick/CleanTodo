//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemDisplayPresenter {
    weak var output: TodoItemDisplayPresenterOutput!
    unowned let router: TodoItemDisplayRouter
    
    private let useCase: TodoItemDisplayUseCase
    
    init(useCase: TodoItemDisplayUseCase, router: TodoItemDisplayRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
        
    func eventModeEdit() {
        router.routeEditView()
    }
}

extension TodoItemDisplayPresenter: TodoItemDisplayUseCaseOutput {
    func present(model: TodoItemDisplayPresentationModel) {
        output.show(model: TodoItemDisplayViewModel(model: model))
    }
}
