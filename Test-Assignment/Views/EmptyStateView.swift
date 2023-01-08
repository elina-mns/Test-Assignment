import UIKit

class EmptyStateView: UIView {
    var emptyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "The list is empty."
        label.textColor = .gray
        return label
    }()
    var emptyStateImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "exclamationmark.icloud")
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyStateImage)
        addSubview(emptyLabel)
        NSLayoutConstraint.activate([
            emptyStateImage.widthAnchor.constraint(equalToConstant: 150),
            emptyStateImage.widthAnchor.constraint(equalTo: emptyStateImage.heightAnchor),
            emptyStateImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptyStateImage.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        emptyLabel.topAnchor.constraint(equalTo: emptyStateImage.bottomAnchor, constant: 20).isActive = true
        emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyStateImage.setContentCompressionResistancePriority(.required, for: .horizontal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
