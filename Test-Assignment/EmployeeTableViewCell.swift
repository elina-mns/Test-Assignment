import UIKit

class EmployeeTableViewCell: UITableViewCell {
    private var employeeSmallImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    private var employeeLargeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    private var fullName: UILabel = {
        let label = UILabel()
        return label
    }()
    private var phoneNumber: UILabel = {
        let label = UILabel()
        return label
    }()
    private var email: UILabel = {
        let label = UILabel()
        return label
    }()
    private var biography: UILabel = {
        let label = UILabel()
        return label
    }()
    private var team: UILabel = {
        let label = UILabel()
        return label
    }()
    private var employeeType: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(employeeSmallImage)
        addSubview(employeeLargeImage)
        addSubview(fullName)
        addSubview(phoneNumber)
        addSubview(email)
        addSubview(biography)
        addSubview(team)
        addSubview(employeeType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}
