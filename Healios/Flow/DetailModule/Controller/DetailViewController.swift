import RxSwift
import UIKit

class DetailViewController: UIViewController, DetailModule, ViewHolder {
    typealias RootViewType = DetailView
    
    private let postInfo: PostInfo
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = DetailView()
    }
    
    init(postInfo: PostInfo) {
        self.postInfo = postInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = postInfo.user.name
        
        bindView()
    }
    
    private func bindView() {
        Observable.just(postInfo.comments)
            .bind(to: rootView.tableView.rx.items(SubtitleTableViewCell.self)) { _, model, cell in
                cell.setupViewModel(title: model.name, subtitle: model.body)
            }
            .disposed(by: disposeBag)
        rootView.headerView.setupViewModel(user: postInfo.user)
    }
}
