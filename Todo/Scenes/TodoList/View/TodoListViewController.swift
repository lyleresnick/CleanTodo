//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListViewController: UIViewController {
    
    private var adapter: TodoListAdapter!
    var presenter: TodoListPresenter!
    @IBOutlet weak var tableView: UITableView!
    var prepareFor: PrepareForSegueClosure!
    
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
        adapter = TodoListAdapter(presenter: presenter)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = adapter
        tableView.dataSource = adapter

        presenter.eventViewReady()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        prepareFor(segue)
    }

    
    @IBAction func addTouched(_ sender: Any) {
        presenter.eventCreate()
    }
}

extension TodoListViewController: TodoListPresenterOutput {}

extension TodoListViewController: TodoListViewReadyPresenterOutput {

    func showTodoList() {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension TodoListViewController: TodoListDeletePresenterOutput {

    func showDeleted(index: Int) {
        
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .bottom)
        }
    }
}

extension TodoListViewController: TodoListChangedPresenterOutput {

    func showChanged(index: Int) {
        
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        }
    }
}

extension TodoListViewController: TodoListCreatePresenterOutput {

    func showAdded(index: Int) {
        
        DispatchQueue.main.async {
            self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .top)
        }
    }
}






