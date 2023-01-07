import UIKit

class EmployeeListAPI {
    
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
    
    class func fetchEmployeesList(completionHandler: @escaping (EmployeesListModel?, Error?) -> Void) {
        let request = URLRequest(url: EndPoints.employees.url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let employeeList = try decoder.decode(EmployeesListModel.self, from: data)
                completionHandler(employeeList, nil)
            } catch {
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    class func fetchMalformedEmployeesList(completionHandler: @escaping (EmployeesListModel?, Error?) -> Void) {
        let request = URLRequest(url: EndPoints.malformedEmployees.url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let employeeList = try decoder.decode(EmployeesListModel.self, from: data)
                completionHandler(employeeList, nil)
            } catch {
                completionHandler(nil, error)
            }
        })
        task.resume()
    }
    
    class func fetchEmptyList(completionHandler: @escaping (EmployeesListModel?, Error?) -> Void) {
        let request = URLRequest(url: EndPoints.emptyList.url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            do {
                let employeeList = try decoder.decode(EmployeesListModel.self, from: data)
                completionHandler(employeeList, nil)
            } catch {
                completionHandler(nil, error)
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
