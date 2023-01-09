import Foundation

protocol EmployeesListViewModelDelegate: AnyObject {
    func showAlert(title: String, message: String, okAction: (() -> Void)?)
    func loadingStarted()
    func loadingEnded()
    func emptyViewIsHidden()
    func emptyViewIsVisible()
}

class EmployeesListViewModel {
    
    private var employeeAPI: EmployeeAPIProtocol
    
    weak var delegate: EmployeesListViewModelDelegate?
    private var employeesList: EmployeesListModel?
    var employeesCount: Int {
        employeesList?.employees.count ?? 0
    }
    
    init(employeeAPI: EmployeeAPIProtocol) {
        self.employeeAPI = employeeAPI
    }
    
    @objc func loadData() {
        self.delegate?.loadingStarted()
        fetchEmployeesList()
    }
    
    func employeeModel(for indexPath: IndexPath) -> EmployeeModel? {
        guard employeesCount > indexPath.row
        else { return nil }
        return employeesList?.employees[indexPath.row]
    }
    
    private func fetchEmployeesList() {
        employeeAPI.fetchEmployeesList(completionHandler: processResult(result:))
    }
    
    private func processResult(result: Result<EmployeesListModel, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                self.processFailure(error: error)
            case .success(let response):
                self.processSuccess(employeesList: response)
            }
        }
    }
    
    private func processFailure(error: Error) {
        delegate?.showAlert(title: "Error",
                            message: "Couldn't load employees list.",
                            okAction: nil)
    }
    
    private func processSuccess(employeesList: EmployeesListModel) {
        self.employeesList = employeesList
        if employeesCount == 0 {
            delegate?.emptyViewIsVisible()
        } else {
            delegate?.emptyViewIsHidden()
        }
        delegate?.loadingEnded()
    }
    
    private func loadEmptyList() {
        employeeAPI.fetchEmptyList(completionHandler: processResult(result:))
    }
    
    private func loadMalformedEmployeesList() {
        employeeAPI.fetchMalformedEmployeesList(completionHandler: processResult(result:))
    }
}
