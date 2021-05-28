import UIKit

final class SubtitleTableViewCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialLayout()
        configureView()
    }
    
    func setupViewModel(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    private func setupInitialLayout() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5)
            ]
        )
    }
    
    private func configureView() {
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 4
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0
        titleLabel.font = .boldSystemFont(ofSize: 15)
        subtitleLabel.font = .systemFont(ofSize: 13)
        titleLabel.textColor = .black
        subtitleLabel.textColor = .lightGray
        selectionStyle = .none
    }
}
