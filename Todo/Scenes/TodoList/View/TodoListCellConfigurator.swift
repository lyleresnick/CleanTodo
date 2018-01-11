//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCellConfigurator {
    
    private enum Cell: String  {
        case todoList
    }
    
    var tableView: UITableView!
    var indexPath: IndexPath!
    
    func set(tableView: UITableView, indexPath: IndexPath) -> Self {
        self.tableView = tableView
        self.indexPath = indexPath
        return self;
    }
    
    func show(viewModel: TodoListViewModel) -> TodoListCell {
        return tableCell().show(viewModel: viewModel)
    }
    
    func tableCell() -> TodoListCell {
        return tableView!.dequeueReusableCell(withIdentifier: Cell.todoList.rawValue, for: indexPath!) as! TodoListCell
    }
}

