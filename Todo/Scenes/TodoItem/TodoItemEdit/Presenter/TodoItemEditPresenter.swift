//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemEditPresenter {
    private let useCase: TodoItemEditUseCase
    unowned let router: TodoItemEditRouter
        
    weak var output: TodoItemEditPresenterOutput!
    
    init(useCase: TodoItemEditUseCase, router: TodoItemEditRouter) {
        self.useCase = useCase
        self.router = router
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
    
    func eventEdited(title: String) {
        useCase.eventEdited(title: title)
    }
    
    func eventEdited(note: String) {
        useCase.eventEdited(note: note)
    }
    
    func eventEdited(completeBySwitch: Bool) {
        useCase.eventEdited(completeBySwitch: completeBySwitch)
    }
        
    func eventEdited(completeBy: Date) {
        useCase.eventEdited(completeBy: completeBy)
    }
    
    func eventEdited(completed: Bool) {
        useCase.eventEdited(completed: completed)
    }
    
    func eventEditedPriority(index: Int) {
        let priority = Priority(bangs: index)!
        useCase.eventEdited(priority: priority)
    }
    
    func eventSave() {
        useCase.eventSave()
    }
    
    func eventCancel() {
        useCase.eventCancel()
    }
}

extension TodoItemEditPresenter: TodoItemEditUseCaseOutput {
    func presentLoading() {
        output.showLoading()
    }
    
    func present(model: TodoItemEditPresentationModel) {
        presentWithLocalizations(model: TodoItemEditViewModel(model: model))
    }
    
    private func presentWithLocalizations(model: TodoItemEditViewModel) {
        output.show(model: model,
            titlePlaceholder: "enterATitle".localized,
            priorityLabels: ["none", "low", "medium", "high"].map { $0.localized })
    }
    
    func present(completeBy: Date?) {
        output.show(completeByAsString: (completeBy != nil)
                    ? TodoItemEditViewModel.outboundDateFormatter.string(from: completeBy!)
                    : "")
    }
    
    func presentSaveCompleted() {
        router.routeSaveCompleted()
    }
    
    func presentEditItemCancelled() {
        router.routeEditItemCancelled()
    }
    
    func presentCreateItemCancelled() {
        router.routeCreateItemCancelled()
    }
    
    func presentTitleIsEmpty() {
        output.showAlert(alertTitle: "titleRequiredTitle".localized, message: "titleRequiredMessage".localized, actionTitle: "OK".localized)
    }
}


