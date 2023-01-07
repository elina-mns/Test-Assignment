import UIKit

class EmployeeTableViewCell: UITableViewCell {
    var employeeSmallImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    var employeeLargeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    var fullName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var phoneNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var biography: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    var team: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var employeeType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(employeeSmallImage)
        addSubview(fullName)
        addSubview(phoneNumber)
        addSubview(email)
        addSubview(biography)
        addSubview(team)
        addSubview(employeeType)
        
        NSLayoutConstraint.activate([
            employeeSmallImage.widthAnchor.constraint(equalToConstant: 20),
            employeeSmallImage.widthAnchor.constraint(equalTo: employeeSmallImage.heightAnchor),
            employeeSmallImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            employeeSmallImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            leadingAnchor.constraint(greaterThanOrEqualTo: fullName.leadingAnchor, constant: 20)
        ])

        employeeSmallImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        fullName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        fullName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        phoneNumber.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 20).isActive = true
        phoneNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        email.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 20).isActive = true
        email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        biography.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20).isActive = true
        biography.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        biography.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        team.topAnchor.constraint(equalTo: biography.bottomAnchor, constant: 20).isActive = true
        team.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        team.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        employeeType.topAnchor.constraint(equalTo: team.bottomAnchor, constant: 20).isActive = true
        employeeType.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        employeeType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        employeeType.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}
