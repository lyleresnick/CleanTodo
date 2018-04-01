//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListViewController: UIViewController {
    
    private var adapter: TodoListAdapter!
    var presenter: TodoListPresenter!
    @IBOutlet weak var tableView: UITableView!
    
    weak var router: TodoListRouter! {
        set {
            presenter.router = newValue
        }
        get {
            return presenter.router
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        TodoListConnector(viewController: self).configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = TodoListAdapter(presenter: presenter)
        tableView.delegate = adapter
        tableView.dataSource = adapter

        presenter.eventViewReady()
    }
    
    @IBAction func addTouched(_ sender: Any) {
        presenter.eventCreate()
    }
}

extension TodoListViewController: TodoListPresenterOutput {

    func showTodoList() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showDeleted(index: Int) {
        
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .bottom)
        }
    }
    
    func showChanged(index: Int) {
        
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
    func showAdded(index: Int) {
        
        DispatchQueue.main.async {
            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .top)
        }
    }
}






