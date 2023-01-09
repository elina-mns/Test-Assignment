import UIKit

class EmployeesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EmployeesListViewModelDelegate {
    
    private enum Constants {
        static let placeholderImageName = "person.crop.circle.badge.exclamationmark"
        static let title = "Employees"
        static let cellIdentifier = "EmployeeTableViewCell"
        static let ok = "Ok"
    }
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var tableView = UITableView()
    var viewModel = EmployeesListViewModel(employeeAPI: EmployeeListAPI())
    var emptyStateView = EmptyStateView()
   
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(viewModel.loadData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.loadData()
        viewModel.delegate = self
        title = Constants.title
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
        tableView.addSubview(refreshControl)
        emptyStateView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func loadingStarted() {
        self.refreshControl.beginRefreshing()
        self.activityIndicator.startAnimating()
    }
    
    func loadingEnded() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    func emptyViewIsHidden() {
        self.emptyStateView.isHidden = true
    }
    
    func emptyViewIsVisible() {
        self.emptyStateView.isHidden = false
    }
    
    func showAlert(title: String, message: String, okAction: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.ok, style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? EmployeeTableViewCell,
              let employeesList = viewModel.employeeModel(for: indexPath) else {
            fatalError("Couldn't configure the cell this time. Table View Cell should be registered.")
        }
        cell.configure(with: employeesList)
        return cell
    }
}
