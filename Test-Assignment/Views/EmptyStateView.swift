import UIKit

class EmptyStateView: UIView {
    
    private enum Constants {
        static let emptyLabelText = "The list is empty."
        static let emptyImageName = "exclamationmark.icloud"
        static let emptyImageWidth = 150.0
        static let emptyLabelTopPadding = 20.0
    }
    var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.emptyLabelText
        label.textColor = .gray
        return label
    }()
    var emptyStateImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: Constants.emptyImageName)
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyStateImage)
        addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyStateImage.widthAnchor.constraint(equalToConstant: Constants.emptyImageWidth),
            emptyStateImage.widthAnchor.constraint(equalTo: emptyStateImage.heightAnchor),
            emptyStateImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        emptyLabel.topAnchor.constraint(equalTo: emptyStateImage.bottomAnchor, constant: Constants.emptyLabelTopPadding).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyStateImage.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
