import Foundation

/* {
     "employees" : [
       {
         "uuid" : "some-uuid",
         "full_name" : "Eric Rogers",
         "phone_number" : "5556669870",
         "email_address" : "erogers.demo@squareup.com",
         "biography" : "A short biography describing the employee.",
         "photo_url_small" : "https://some.url/path1.jpg",
         "photo_url_large" : "https://some.url/path2.jpg",
         "team" : "Seller",
         "employee_type" : "FULL_TIME",
       },
       ...
     ]
   }
*/

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
    let employeeType: String
    
    
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
}
