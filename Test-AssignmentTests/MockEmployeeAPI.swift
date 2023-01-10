import Foundation
@testable import Test_Assignment

final class MockEmployeeAPI: EmployeeAPIProtocol {
    
    var stubbedResult: Result<EmployeesListModel, Error>!
    
    func fetchEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        completionHandler(stubbedResult)
    }
    
    func fetchMalformedEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        completionHandler(stubbedResult)
    }
    
    func fetchEmptyList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        completionHandler(stubbedResult)
    }
}
