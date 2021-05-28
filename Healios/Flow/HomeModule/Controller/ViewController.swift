import RxSwift
import UIKit

class ViewController: UIViewController, HomeModule, ViewHolder {
    typealias RootViewType = HomeView
    var onElementTapped: OnElementTapped?
    
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = HomeView()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let output = viewModel.transform(input: .init(viewDidLoad: .just(())))
        
        let userList = output.userList.publish()
        userList.connect()
            .disposed(by: disposeBag)
        
        let commentList = output.commentList.publish()
        commentList.connect()
            .disposed(by: disposeBag)
        let postList = output.postsList.publish()
        
        postList.element
            .bind(to: rootView.tableView.rx.items(UITableViewCell.self)) { _, model, cell in
                cell.textLabel?.text = model.title
                cell.detailTextLabel?.text = model.body
            }
            .disposed(by: disposeBag)
        
        rootView.tableView.rx.itemSelected
            .withLatestFrom(Observable.combineLatest(postList.element, userList.element, commentList.element)) { indexPath, postInfo -> PostInfo in
                let selectedPost = postInfo.0[indexPath.row]
                let postedUser = postInfo.1.filter { $0.id == selectedPost.userId }.first!
                let postComments = postInfo.2.filter { $0.postID == selectedPost.id}
                return PostInfo(user: postedUser, comments: postComments, post: selectedPost)
            }.subscribe(onNext: { [weak self] post in
                self?.onElementTapped?(post)
            })
            .disposed(by: disposeBag)
        
        postList.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        postList.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        postList.connect()
            .disposed(by: disposeBag)
    }
}

