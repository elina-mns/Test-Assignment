import UIKit

protocol EmployeeAPIProtocol {
    func fetchEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void)
    func fetchMalformedEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void)
    func fetchEmptyList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void)
}

class EmployeeListAPI: EmployeeAPIProtocol {
    
    enum APIError: Error {
        case badResponse
        case decodingError(Error)
    }
    
    enum EndPoints {
        case employees
        case malformedEmployees
        case emptyList
        var url: URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String {
            switch self {
            case .employees:
                return "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
            case .malformedEmployees:
                return "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
            case .emptyList:
                return "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
            }
        }
    }
    
    func fetchEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        fetch(endpoint: EndPoints.employees, completion: completionHandler)
    }
    
    func fetchMalformedEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        fetch(endpoint: EndPoints.malformedEmployees, completion: completionHandler)
    }
    
    func fetchEmptyList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        fetch(endpoint: EndPoints.emptyList, completion: completionHandler)
    }
    
    private func fetch<Success: Decodable>(endpoint: EndPoints, completion: @escaping (Result<Success, Error>) -> Void) {
        let request = URLRequest(url: endpoint.url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else {
                completion(.failure(APIError.badResponse))
                return
            }
            let decoder = JSONDecoder()
            do {
                let employeeList = try decoder.decode(Success.self, from: data)
                completion(.success(employeeList))
            } catch {
                completion(.failure(APIError.decodingError(error)))
            }
        })
        task.resume()
    }
}
