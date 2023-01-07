import UIKit

class EmployeesListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    var employeesList: EmployeesListModel?
    var tableView = UITableView()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadData()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "EmployeeTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func loadData() {
        EmployeeListAPI.fetchEmployeesList { response, error in
            DispatchQueue.main.async {
                if error != nil {
                    self.showAlert(title: "Error", message: "Couldn't perform the request this time.", okAction: nil)
                } else if let responseExpected = response {
                    self.employeesList = responseExpected
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                }
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
        guard employeesList != nil else { return 0 }
        return (employeesList?.employees.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as? EmployeeTableViewCell else {
            fatalError("Couldn't configure the cell this time. Table View Cell should be registered.")
        }
        let employeesList = employeesList?.employees[indexPath.row]
        
        cell.fullName.text = employeesList?.fullName
        cell.phoneNumber.text = employeesList?.phoneNumber
        cell.email.text = employeesList?.emailAddress
        cell.biography.text = employeesList?.biography
        cell.team.text = employeesList?.team
        cell.employeeType.text = employeesList?.employeeType
        
        cell.employeeLargeImage.image = UIImage(systemName: "person.crop.circle.badge.exclamationmark")
        if let employeeImage = URL(string: employeesList?.largePhotoURL ?? "") {
            cell.employeeLargeImage.downloadImage(from: employeeImage) { (image) in
                if image != nil {
                    cell.employeeLargeImage.image = image
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

