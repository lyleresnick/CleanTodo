//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemDisplayPresenter {
    
    weak var output: TodoItemDisplayPresenterOutput!
    weak var router: TodoItemDisplayRouter!
    
    private let useCase: TodoItemDisplayUseCase
    
    init(useCase: TodoItemDisplayUseCase) {
        self.useCase = useCase
    }
    
    func eventViewReady() {
        useCase.eventViewReady()
    }
        
    func eventModeEdit() {
        router.routeEditView()
    }
}

extension TodoItemDisplayPresenter: TodoItemDisplayUseCaseOutput {

    private static let outboundDateFormatter = DateFormatter.dateFormatter( format: "MMM' 'dd', 'yyyy" )
    
    func presentBegin() {
        output.showBegin()
    }
    
    func present(field: FieldName, value: String) {
        let fieldName = field.rawValue.localized
        output.show(model: TodoItemDisplayRowViewModel(fieldName: fieldName, value: value))
    }
    
    func present(field: FieldName, value: Date) {
        present(field: field, value: TodoItemDisplayPresenter.outboundDateFormatter.string(from: value))
    }
    
    func present(field: FieldName, value: Bool) {
        present(field: field, value: (value ? "yes" : "no").localized)
    }
    
    func present(field: FieldName, value: Priority) {
        present(field: field, value: value.rawValue.localized)
    }

    func presentEnd() {
        output.showEnd()
    }
}
