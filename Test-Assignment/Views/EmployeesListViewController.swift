import UIKit

class EmployeesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var employeesList: EmployeesListModel?
    var tableView = UITableView()
    var emptyStateView = EmptyStateView()
    let placeholderImage = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
        title = "Employees"
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
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "EmployeeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            emptyStateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyStateView.topAnchor.constraint(equalTo: view.topAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func loadData() {
        self.refreshControl.beginRefreshing()
        EmployeeListAPI.fetchEmployeesList { result in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                switch result {
                case .failure:
                    self.showAlert(title: "Error", message: "Couldn't load employees list.", okAction: nil)
                case .success(let response):
                    //self.employeesList = response
                    if self.employeesList == nil {
                        self.loadEmptyList()
                    }
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func loadEmptyList() {
        self.refreshControl.beginRefreshing()
        EmployeeListAPI.fetchEmptyList { result in
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                switch result {
                case .failure:
                    self.showAlert(title: "Error", message: "Couldn't load empty list.", okAction: nil)
                case .success(let response):
                    self.employeesList = response
                }
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showAlert(title: String, message: String, okAction: (() -> Void)?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let employeesList else { return 1 }
        return employeesList.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as? EmployeeTableViewCell else {
            fatalError("Couldn't configure the cell this time. Table View Cell should be registered.")
        }
        if let employeesList = employeesList?.employees[indexPath.row] {
            cell.fullName.text = "Name: \(employeesList.fullName)"
            let formattedPhoneNumber = employeesList.phoneNumber.toPhoneNumber()
            cell.phoneNumber.text = "Phone: \(formattedPhoneNumber)"
            cell.email.text = "Email: \(employeesList.emailAddress)"
            cell.biography.text = "Biography: \(employeesList.biography)"
            cell.team.text = "Team: \(employeesList.team)"
            cell.employeeType.text = "Employee type: \(employeesList.employeeType.description)"
            cell.employeeImage.image = placeholderImage
            if let employeeImage = URL(string: employeesList.smallPhotoURL) {
                cell.employeeImage.downloadImage(from: employeeImage, placeholder: placeholderImage)
            }
        }
        return cell
    }
}
