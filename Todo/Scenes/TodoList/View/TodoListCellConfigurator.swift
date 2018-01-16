//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCellConfigurator {
    
    private enum Cell: String  {
        case todoList
    }
    
    private(set) var presenter: TodoListPresenter!
    private(set) var tableView: UITableView!
    private(set) var indexPath: IndexPath!
    
    func set(tableView: UITableView, indexPath: IndexPath, presenter: TodoListPresenter) -> Self {
        self.presenter = presenter
        self.tableView = tableView
        self.indexPath = indexPath
        return self;
    }
    
    func show(viewModel: TodoListViewModel, presenter: TodoListPresenter) -> TodoListCell {
        return tableCell().show(viewModel: viewModel, index: indexPath.row, presenter: presenter)
    }
    
    func tableCell() -> TodoListCell {
        return tableView!.dequeueReusableCell(withIdentifier: Cell.todoList.rawValue, for: indexPath!) as! TodoListCell
    }
}

