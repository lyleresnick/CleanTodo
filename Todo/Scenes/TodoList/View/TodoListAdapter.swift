//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListAdapter: NSObject {
    
    var presenter: TodoListPresenter!
    let cellConfigurator: TodoListCellConfigurator
    
    init(cellConfigurator: TodoListCellConfigurator = TodoListCellConfigurator() ) {
        self.cellConfigurator = cellConfigurator
    }
}

extension TodoListAdapter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cellConfigurator
            .set( tableView: tableView, indexPath: indexPath )
            .show( viewModel: presenter.row( at: indexPath.row ))
    }
}

extension TodoListAdapter: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.eventItemSelected(row: indexPath.row)
    }
}
