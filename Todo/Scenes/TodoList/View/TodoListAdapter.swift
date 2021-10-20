//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListAdapter: NSObject {
    
    let presenter: TodoListPresenter
    let cellConfigurator = TodoListCellConfigurator()
    
    init(presenter: TodoListPresenter) {
        self.presenter = presenter
    }
    var model: TodoListViewModel!
}

extension TodoListAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cellConfigurator
            .set(tableView: tableView, indexPath: indexPath, presenter: presenter)
            .show(viewModel: model.todoList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        presenter.eventDelete(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}

extension TodoListAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.eventItemSelected(index: indexPath.row)
    }
    
}
