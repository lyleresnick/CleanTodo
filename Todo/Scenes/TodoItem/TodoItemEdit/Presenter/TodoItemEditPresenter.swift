//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemEditPresenter {
    
    private let useCase: TodoItemEditUseCase
    weak var router: TodoItemEditRouter! {
        didSet {
            useCase.state = router.state
        }
    }
    
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
        
    func eventCompleteByShowKeyboard() {
        useCase.eventCompleteByShowKeyboard()
    }
    
    func event(completeBy: Date) {
        useCase.event(completeBy: completeBy)
    }
    
    func event(completed: Bool) {
        useCase.event(completed: completed)
    }
    
    func eventPriority(index: Int) {
        
        let priority = Todo.Priority(bangs: index)!
        useCase.event(priority: priority)
    }
    
    func eventSave() {
        useCase.eventSave()
    }
    
    func eventCancel() {
        switch editMode  {
        case .create:
            router.routeCreateItemCancelled()
        case .update:
            router.routeDisplayView()
        }
    }
    
    static let priortyTitles = ["none", "low", "medium", "high"].map { title in
        return title.localized
    }
}

extension TodoItemEditPresenter: TodoItemEditUseCaseOutput {}

extension TodoItemEditPresenter: TodoItemEditViewReadyUseCaseOutput {

    func present(model: TodoItemEditPresentationModel) {
        output.show(model: TodoItemEditViewModel(model: model))
    }
    
    func presentNewModel() {
        output.showNewModel()
    }
}

extension TodoItemEditPresenter: TodoItemEditCompleteByUseCaseOutput {

    func presentKeyboardHidden() {
        output.showKeyboardHidden()
    }
    
    func presentKeyboard(completeBy: Date?) {
        output.showKeyboard(completeBy: completeBy)
    }
    
    func present(completeBy: Date?) {
        
        output.show(completeBy: (completeBy != nil) ? TodoItemEditViewModel.outboundDateFormatter.string(from: completeBy!) : "")
    }
}

extension TodoItemEditPresenter: TodoItemEditSaveUseCaseOutput {
    
    func presentDisplayView() {
        router.routeDisplayView()
    }
    
    func presentTitleIsEmpty() {
        output.showTitleIsEmpty(alertTitle: "Title is empty", message: "Enter a Title")
    }
}


