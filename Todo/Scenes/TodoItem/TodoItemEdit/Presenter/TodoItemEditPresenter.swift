//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemEditPresenter {
    
    private let useCase: TodoItemEditUseCase
    weak var router: TodoItemEditRouter!
    
    var editMode: TodoItemEditMode {
        get {
            return useCase.editMode
        }
        set {
            useCase.editMode = newValue
        }
    }
    
    weak var output: TodoItemEditPresenterOutput!
    
    init(useCase: TodoItemEditUseCase) {
        self.useCase = useCase
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
    
    func eventCompleteByClear() {
        useCase.eventCompleteByClear()
    }
    
    func eventCompleteByToday() {
        useCase.eventCompleteByToday()
    }
        
    func eventEnableEditCompleteBy() {
        useCase.eventEnableEditCompleteBy()
    }
    
    func eventEdited(completeBy: Date) {
        useCase.eventEdited(completeBy: completeBy)
    }
    
    func event(completed: Bool) {
        useCase.event(completed: completed)
    }
    
    func eventEditedPriority(index: Int) {
        
        let priority = Priority(bangs: index)!
        useCase.eventEdited(priority: priority)
    }
    
    func eventSave() {
        useCase.eventSave()
    }
    
    func eventCancel() {
        router.routeEditingCancelled()
    }
}

extension TodoItemEditPresenter: TodoItemEditUseCaseOutput {}

extension TodoItemEditPresenter: TodoItemEditViewReadyUseCaseOutput {

    func present(model: TodoItemEditPresentationModel) {
        presentWithLocalizations(model: TodoItemEditViewModel(model: model))
    }
    
    func presentNewModel() {
        presentWithLocalizations(model: TodoItemEditViewModel())
    }
    
    private func presentWithLocalizations(model: TodoItemEditViewModel) {
        output.show(model: model,
            titlePlaceholder: "enterATitle".localized,
            priorityLabels: ["none", "low", "medium", "high"].map { $0.localized })
    }
}

extension TodoItemEditPresenter: TodoItemEditCompleteByUseCaseOutput {

    func presentCompleteByClear() {
        output.showCompleteByClear()
    }
    
    func presentEnableEdit(completeBy: Date?) {
        output.showEnableEdit(completeBy: completeBy)
    }
    
    func present(completeBy: Date?) {
        output.show(completeBy: (completeBy != nil)
            ? TodoItemEditViewModel.outboundDateFormatter.string(from: completeBy!)
            : "")
    }
}

extension TodoItemEditPresenter: TodoItemEditSaveUseCaseOutput {
    
    func presentSaveCompleted() {
        router.routeSaveCompleted()
    }
    
    func presentTitleIsEmpty() {
        output.showAlert(alertTitle: "titleRequiredTitle".localized, message: "titleRequiredMessage".localized, actionTitle: "OK".localized)
    }
}


