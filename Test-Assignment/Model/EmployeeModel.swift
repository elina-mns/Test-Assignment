import Foundation

struct EmployeesListModel: Decodable {
    let employees: [EmployeeModel]
}

struct EmployeeModel: Decodable {
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let smallPhotoURL: String
    let largePhotoURL: String
    let team: String
    let employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case smallPhotoURL = "photo_url_small"
        case largePhotoURL = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }

    enum EmployeeType: String, Codable {
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
        case contractor = "CONTRACTOR"
        
        var description: String {
            switch self {
            case .fullTime:
                return "Full Time"
            case .partTime:
                return "Part Time"
            case .contractor:
                return "Contractor"
            }
        }
    }
}
