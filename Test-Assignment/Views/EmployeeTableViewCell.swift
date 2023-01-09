import UIKit

class EmployeeTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let placeholderImageName = "person.crop.circle.badge.exclamationmark"
        static let cornerRadiusConstant = 20.0
        static let employeeImageWidth = 120.0
        static let paddingLarge = 20.0
        static let paddingSmall = 10.0
        static let paddingMedium = 15.0
        static let name = "Name: "
        static let phone = "Phone: "
        static let email = "Email: "
        static let biography = "Biography: "
        static let team = "Team: "
        static let employeeType = "Employee type: "
    }
    
    private let placeholderImage = UIImage(systemName: Constants.placeholderImageName)
    
    private var employeeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.cornerRadiusConstant
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()

    private var fullName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var phoneNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var email: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var biography: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var team: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private var employeeType: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        NSLayoutConstraint.activate([
            employeeImage.widthAnchor.constraint(equalToConstant: Constants.employeeImageWidth),
            employeeImage.widthAnchor.constraint(equalTo: employeeImage.heightAnchor),
            employeeImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingLarge),
            employeeImage.topAnchor.constraint(equalTo: topAnchor, constant: Constants.paddingLarge),

            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: fullName.leadingAnchor, constant: -Constants.paddingMedium),
            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: team.leadingAnchor, constant: -Constants.paddingMedium),
            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: employeeType.leadingAnchor, constant: -Constants.paddingMedium),
            employeeImage.trailingAnchor.constraint(greaterThanOrEqualTo: phoneNumber.leadingAnchor, constant: -Constants.paddingMedium)
        ])

        employeeImage.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        fullName.topAnchor.constraint(equalTo: topAnchor, constant: Constants.paddingLarge).isActive = true
        fullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingLarge).isActive = true
        
        team.topAnchor.constraint(equalTo: fullName.bottomAnchor, constant: Constants.paddingSmall).isActive = true
        team.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingLarge).isActive = true
        
        employeeType.topAnchor.constraint(equalTo: team.bottomAnchor, constant: Constants.paddingSmall).isActive = true
        employeeType.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingLarge).isActive = true
        
        phoneNumber.topAnchor.constraint(equalTo: employeeType.bottomAnchor, constant: Constants.paddingSmall).isActive = true
        phoneNumber.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingLarge).isActive = true
        
        email.topAnchor.constraint(equalTo: employeeImage.bottomAnchor, constant: Constants.paddingMedium).isActive = true
        email.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingLarge).isActive = true
        email.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.paddingLarge).isActive = true
        
        biography.topAnchor.constraint(equalTo: email.bottomAnchor, constant: Constants.paddingSmall).isActive = true
        biography.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.paddingLarge).isActive = true
        biography.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.paddingLarge).isActive = true
        biography.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.paddingLarge).isActive = true
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func configure(with model: EmployeeModel) {
        fullName.text = "\(Constants.name + model.fullName)"
        let formattedPhoneNumber = model.phoneNumber.toPhoneNumber()
        phoneNumber.text = "\(Constants.phone + formattedPhoneNumber)"
        email.text = "\(Constants.email + model.emailAddress)"
        biography.text = "\(Constants.biography + model.biography)"
        team.text = "\(Constants.team + model.team)"
        employeeType.text = "\(Constants.employeeType + model.employeeType.description)"
        employeeImage.image = placeholderImage
        if let employeeImageURL = URL(string: model.smallPhotoURL) {
            employeeImage.downloadImage(from: employeeImageURL, placeholder: placeholderImage)
        }
    }
}
