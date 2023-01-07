import UIKit

class EmployeeListAPI {
    
    enum APIError: Error {
        case badResponse
        case emptyResponse
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
    
    class func fetchEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        fetch(endpoint: EndPoints.employees, completion: completionHandler)
    }
    
    class func fetchMalformedEmployeesList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        fetch(endpoint: EndPoints.malformedEmployees, completion: completionHandler)
    }
    
    class func fetchEmptyList(completionHandler: @escaping (Result<EmployeesListModel, Error>) -> Void) {
        fetch(endpoint: EndPoints.emptyList, completion: completionHandler)
    }
    
    class func fetch<Success: Decodable>(endpoint: EndPoints, completion: @escaping (Result<Success, Error>) -> Void) {
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

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func downloadImage(from url: URL, placeholder: UIImage?) {
        DispatchQueue.global().async {
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                self.set(image: image)
            } else {
                self.set(image: placeholder)
                URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                    else {
                        return
                    }
                    DispatchQueue.main.async() {
                        self?.image = image
                    }
                }).resume()
            }
        }
    }
    private func set(image: UIImage?) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
}
