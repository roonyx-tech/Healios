import UIKit

final class UserView: UIView {
    private lazy var verticalStackView = UIStackView(arrangedSubviews: [])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewModel(user: User) {
        let infoItem: [UserInfoItem] = [.name, .userName, .email, .company, .phone, .webSitre]
        infoItem.forEach { item in
            let label = UILabel()
            label.font = .systemFont(ofSize: 15)
            switch item {
            case .name:
                label.text = "Name: " + user.name
            case .userName:
                label.text = "Username: " + user.username
            case .email:
                label.text = "Email: " + user.email
            case .adress:
                label.text = "Adress: " + user.address.street
            case .company:
                label.text = "Company: " + user.company.name
            case .phone:
                label.text = "Phone: " + user.phone
            case .webSitre:
                label.text = "Website: " + user.website
            }
            label.numberOfLines = 0
            label.textColor = .black
            label.textAlignment = .left
            verticalStackView.addArrangedSubview(label)
        }
    }
    
    private func setupInitialLayout() {
        addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
            ]
        )
    }
    
    private func configureView() {
        verticalStackView.spacing = 3
        verticalStackView.distribution = .fill
        verticalStackView.axis = .vertical
        verticalStackView.sizeToFit()
    }
}
