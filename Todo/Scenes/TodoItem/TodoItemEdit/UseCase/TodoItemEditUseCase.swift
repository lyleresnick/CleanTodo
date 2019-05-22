//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemEditUseCase {
    
    weak var output: TodoItemEditUseCaseOutput!
    
    struct EditingTodo {
        
        var id: String?
        var title: String
        var note: String
        var completeBy: Date?
        var priority: Todo.Priority
        var completed: Bool
        
        init(id: String? = nil,
            title: String = "",
            note: String = "",
            completeBy: Date? = nil,
            priority: Todo.Priority = .none,
            completed: Bool = false) {
            
            self.id = id
            self.title = title
            self.note = note
            self.completeBy = completeBy
            self.priority = priority
            self.completed = completed
        }
    }
    
    private var editingTodo: EditingTodo!
    var editMode: TodoItemEditMode!
    
    private let entityGateway: EntityGateway
    private let itemState: TodoItemUseCaseState

    init( entityGateway: EntityGateway = EntityGatewayFactory.entityGateway,
          useCaseStore: UseCaseStore = RealUseCaseStore.store ) {
        
        self.entityGateway = entityGateway
        self.itemState = useCaseStore[itemStateKey] as! TodoItemUseCaseState
    }
    
    // MARK: - Initialization

    func eventViewReady() {

        let transformer = TodoItemEditViewReadyUseCaseTransformer(editMode: editMode, state: itemState)
        editingTodo = transformer.transform(output: output)
    }

    // MARK: - Data Capture
    
    func eventEdited(title: String) {
        editingTodo.title = title
    }
    
    func eventEdited(note: String) {
        editingTodo.note = note
    }
    
    func eventCompleteByClear() {
        editingTodo.completeBy = nil
        output.presentCompleteByClear()
    }
    
    func eventCompleteByToday() {
        editingTodo.completeBy = Date()
        output.present(completeBy: editingTodo.completeBy)
    }
    
    func eventEnableEditCompleteBy() {
        output.presentEnableEdit(completeBy: editingTodo.completeBy)
    }

    func eventEdited(completeBy: Date) {
        editingTodo.completeBy = completeBy
        output.present(completeBy: completeBy)
    }
    
    func event(completed: Bool) {
        editingTodo.completed = completed
    }

    func eventEdited(priority: Todo.Priority ) {
        editingTodo.priority = priority

    }
    
    // MARK: - Finalization
    
    func eventSave() {
        
        let transformer = TodoItemEditSaveUseCaseTransformer(editMode: editMode, todoManager: entityGateway.todoManager, state: itemState)
        transformer.transform(editingTodo: editingTodo, output: output)
    }
}
