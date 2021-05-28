import RxSwift

final class HomeViewModel: ViewModel {
    private let apiService = assembler.resolver.resolve(ApiService.self)!
    private let postsCache = Cache<String, [Post]>()
    private let usersCache = Cache<String, [User]>()
    private let commentsCache = Cache<String, [Comment]>()
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let postsList: Observable<LoadingSequence<[Post]>>
        let userList: Observable<LoadingSequence<[User]>>
        let commentList: Observable<LoadingSequence<[Comment]>>
    }
    
    func transform(input: Input) -> Output {
        let postsLists = input.viewDidLoad
            .flatMap { [unowned self] in
                return getPosts().asLoadingSequence()
            }.share()
        
        let userList = input.viewDidLoad
            .flatMap { [unowned self] in
                return self.getUsers().asLoadingSequence()
            }.share()
        
        let commentList = input.viewDidLoad
            .flatMap { [unowned self] in
                return self.getComment().asLoadingSequence()
            }.share()
        
        return .init(postsList: postsLists, userList: userList, commentList: commentList)
    }
    
    private func getPosts() -> Observable<[Post]> {
        if let posts: [Post] = try? postsCache.readFromDisk(name: HomeViewModel.postsCacheKey)  {
            return .just(posts)
        }
        return loadPosts()
    }
    
    private func loadPosts() -> Observable<[Post]> {
        return apiService.makeRequest(to: HomeApiTarget.posts)
            .result([Post].self)
            .do(afterNext: { [weak self] result in
                try? self?.postsCache.saveToDisk(name: HomeViewModel.postsCacheKey, value: result)
            })
    }
    
    private func getComment() -> Observable<[Comment]> {
        if let comments: [Comment] = try? commentsCache.readFromDisk(name: HomeViewModel.commentsCacheKey)  {
            return .just(comments)
        }
        return loadComments()
    }
    
    private func loadComments() -> Observable<[Comment]> {
        return apiService.makeRequest(to: HomeApiTarget.comments)
            .result([Comment].self)
            .do(afterNext: { [weak self] result in
                try? self?.commentsCache.saveToDisk(name: HomeViewModel.commentsCacheKey, value: result)
            })
    }
    
    private func getUsers() -> Observable<[User]> {
        if let users: [User] = try? usersCache.readFromDisk(name: HomeViewModel.usersCacheKey)  {
            return .just(users)
        }
        return loadUsers()
    }
    
    private func loadUsers() -> Observable<[User]> {
        return apiService.makeRequest(to: HomeApiTarget.users)
            .result([User].self)
            .do(afterNext: { [weak self] result in
                try? self?.usersCache.saveToDisk(name: HomeViewModel.usersCacheKey, value: result)
            })
    }
}

private extension HomeViewModel {
    static let postsCacheKey = "postsCache"
    static let usersCacheKey = "usersCache"
    static let commentsCacheKey = "commentsCache"
}

