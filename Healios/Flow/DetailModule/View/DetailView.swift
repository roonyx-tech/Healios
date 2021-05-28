import UIKit

final class DetailView: UIView {
    let tableView = UITableView()
    let headerView = UserView()
    private lazy var verticalStackView = UIStackView(arrangedSubviews: [headerView, tableView])

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInitialLayout()
        configureView()
    }
    
    private func setupInitialLayout() {
        addSubview(headerView)
        addSubview(tableView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
                headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ]
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10),
                tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor)
            ]
        )
    }
    
    private func configureView() {
        backgroundColor = .white
        tableView.registerClassForCell(SubtitleTableViewCell.self)
    }
}
