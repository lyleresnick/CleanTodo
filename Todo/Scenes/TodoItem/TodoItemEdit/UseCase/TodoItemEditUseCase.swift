//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

class TodoItemEditUseCase {
    
    weak var output: TodoItemEditUseCaseOutput!
    weak var state: TodoItemUseCaseState!
    
    struct EditingTodo {
        
        var id: String?
        var title: String
        var note: String
        var completeBy: Date?
        var priority: Todo.Priority?
        var completed: Bool
        
        init(id: String? = nil,
            title: String = "",
            note: String = "",
            completeBy: Date? = nil,
            priority: Todo.Priority? = nil,
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
    
    init( entityGateway: EntityGateway ) {
        
        self.entityGateway = entityGateway
    }
    
    // MARK: - Initialization

    func eventViewReady() {

        let transformer = TodoItemEditViewReadyUseCaseTransformer(editMode: editMode, state: state)
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
        output.presentKeyboardHidden()
    }
    
    func eventCompleteByToday() {
        editingTodo.completeBy = Date()
        output.present(completeBy: editingTodo.completeBy)
    }
    
    func eventCompleteByShowKeyboard() {
        output.presentKeyboard(completeBy: editingTodo.completeBy)
    }

    func event(completeBy: Date) {
        editingTodo.completeBy = completeBy
        output.present(completeBy: completeBy)
    }
    
    func event(completed: Bool) {
        editingTodo.completed = completed
    }

    func event(priority: Todo.Priority? ) {
        editingTodo.priority = priority

    }
    
    // MARK: - Finalization
    
    func eventSave() {
        
        let transformer = TodoItemEditSaveUseCaseTransformer(editMode: editMode, todoManager: entityGateway.todoManager, state: state)
        transformer.transform(editingTodo: editingTodo, output: output)
    }
}
