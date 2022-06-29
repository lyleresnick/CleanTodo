//  Copyright (c) 2018 Lyle Resnick. All rights reserved.

import UIKit

class TodoListViewController: UIViewController, SpinnerAttachable {
    private var adapter: TodoListAdapter!
    var presenter: TodoListPresenter!
    @IBOutlet weak var tableView: UITableView!
    private var spinnerView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = TodoListAdapter(presenter: presenter)
        spinnerView = attachSpinner()
        tableView.delegate = adapter
        tableView.dataSource = adapter
        presenter.eventViewReady()
    }
    
    @IBAction func addTouched(_ sender: Any) {
        presenter.eventCreate()
    }
}

extension TodoListViewController: TodoListPresenterOutput {
    func showLoading() {
        DispatchQueue.main.async { [ weak self] in
            self?.spinnerView.startAnimating()
        }
    }
    
    func showChanged(model: TodoListViewModel) {
        adapter.model = model
        DispatchQueue.main.async { [ weak self] in
            self?.spinnerView.stopAnimating()
            self?.tableView.reloadData()
        }
    }

    func showTodoList(model: TodoListViewModel ) {
        adapter.model = model
        DispatchQueue.main.async { [ weak self] in
            self?.spinnerView.stopAnimating()
            self?.tableView.reloadData()
        }
    }

    func showDeleted(model: TodoListViewModel, index: Int) {
        adapter.model = model
        DispatchQueue.main.async { [ weak self] in
            self?.spinnerView.stopAnimating()
            self?.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .bottom)
        }
    }

    func showCompleted(model: TodoListViewModel, index: Int) {
        DispatchQueue.main.async { [ weak self] in
            self?.spinnerView.stopAnimating()
            self?.adapter.model = model
        }
        
        // the output was previously updated due to the immediate toggle state change
        // if this were not the case, an async call would delay the update of the screen
        // if a network error occurs or it turns out the item was deleted by another user, the app should present a message about the situation and, in the former case, reset the button to the previous state; in the latter case the item should be deleted

    }
}






