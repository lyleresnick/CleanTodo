//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListViewController: UIViewController {
    
    fileprivate var adapter = TodoListAdapter()
    var presenter: TodoListPresenter!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = adapter
            tableView.dataSource = adapter
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        TodoListConnector(viewController: self, adapter: adapter).configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.eventViewReady()
    }
}

extension TodoListViewController: TodoListPresenterOutput {

    func showTodoList() {
        tableView.reloadData()
    }
    
}





