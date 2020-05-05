//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import Foundation

enum  ItemIssue {
    case notFound
}

enum  DeleteIssue {
    case noData
    case notFound
}

protocol TodoManager {
    
    func all(completion: @escaping (Response<[Todo], Void>) -> ())
    func completed(id: String, completed: Bool, completion: @escaping (Response<Todo, ItemIssue>) -> ())
    
    func create(
        values: TodoValues,
        completion: @escaping (Response<Todo, Void>) -> ())
    
    func update(id: String,
        values: TodoValues,
        completion: @escaping (Response<Todo, ItemIssue>) -> ())
    
    func fetch(id:String, completion: @escaping (Response<Todo, ItemIssue>) -> ())
    
    func delete(id:String, completion: @escaping (Response<Todo?, DeleteIssue>) -> ())
}



