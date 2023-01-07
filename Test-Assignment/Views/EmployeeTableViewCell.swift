import UIKit

class EmployeeTableViewCell: UITableViewCell {
    var employeeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    var employeeType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    var emptyStateImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = true
        imageView.image = UIImage(systemName: "exclamationmark.icloud")
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(employeeImage)
        addSubview(fullName)
        addSubview(phoneNumber)
        addSubview(email)
        addSubview(biography)
        addSubview(team)
        addSubview(employeeType)
        addSubview(emptyLabel)
        addSubview(emptyStateImage)
        
        NSLayoutConstraint.activate([
            employeeImage.widthAnchor.constraint(equalToConstant: 120),
            employeeImage.widthAnchor.constraint(equalTo: employeeImage.heightAnchor),
            employeeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            employeeImage.topAnchor.constraint(equalTo: topAnchor, constant: 20),

            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: fullName.leadingAnchor, constant: -15),
            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: team.leadingAnchor, constant: -15),
            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: employeeType.leadingAnchor, constant: -15),
            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: phoneNumber.leadingAnchor, constant: -15)
        ])

        employeeImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        fullName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        fullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        team.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: 10).isActive = true
        team.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        employeeType.topAnchor.constraint(equalTo: team.bottomAnchor, constant: 10).isActive = true
        employeeType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        phoneNumber.topAnchor.constraint(equalTo: employeeType.bottomAnchor, constant: 10).isActive = true
        phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        email.topAnchor.constraint(equalTo: employeeImage.bottomAnchor, constant: 15).isActive = true
        email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        biography.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10).isActive = true
        biography.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        biography.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        biography.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            emptyStateImage.widthAnchor.constraint(equalToConstant: 20),
            emptyStateImage.widthAnchor.constraint(equalTo: emptyStateImage.heightAnchor),
            emptyStateImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            rightAnchor.constraint(greaterThanOrEqualTo: emptyLabel.rightAnchor, constant: 20)
        ])
        
        emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        emptyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        emptyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}
