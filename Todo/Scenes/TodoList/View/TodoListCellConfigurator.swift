//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListCellConfigurator {
    private enum Cell: String  {
        case todoList
    }
    
    private var presenter: TodoListPresenter!
    private var tableView: UITableView!
    private var indexPath: IndexPath!
    
    func set(tableView: UITableView, indexPath: IndexPath, presenter: TodoListPresenter) -> Self {
        self.presenter = presenter
        self.tableView = tableView
        self.indexPath = indexPath
        return self;
    }
    
    func show(viewModel: TodoListRowViewModel) -> TodoListCell {
        return tableCell().show(viewModel: viewModel)
    }
    
    func tableCell() -> TodoListCell {
        let cell = tableView!.dequeueReusableCell(withIdentifier: Cell.todoList.rawValue, for: indexPath!) as! TodoListCell
        // these are for use by "swipe to delete" and by "on/off checkbox touched"
        cell.presenter = presenter
        cell.tableView = tableView
        return cell
    }
}

