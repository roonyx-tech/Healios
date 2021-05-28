import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator {
    override init(router: Router) {
        super.init(router: router)
    }
    
    override func start() {
        var module = makeHome()
        module.onElementTapped = { [weak self] postInfo in
            self?.router.push(self?.makeDetail(postInfo: postInfo))
        }
        router.setRootModule(module)
    }
    
    func makeHome() -> HomeModule {
        return ViewController()
    }
    
    func makeDetail(postInfo: PostInfo) -> DetailModule {
        return DetailViewController(postInfo: postInfo)
    }
}

