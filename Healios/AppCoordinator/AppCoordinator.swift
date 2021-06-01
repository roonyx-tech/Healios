import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator {
    override init(router: Router) {
        super.init(router: router)
    }
    
    override func start() {
        var module = makeMain()
        router.setRootModule(module)
    }
    
    private func openMain() {
        let module = makeMain()
        router.push(module)
    }
    
    func makeAuth() -> AuthModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let viewModel = AuthViewModel(apiService: apiService)
        return AuthViewController(viewModel: viewModel)
    }
    
    func makeMain() -> MainModule {
        return MainViewContorller()
    }
    
    func makeHome() -> HomeModule {
        return ViewController()
    }
    
    func makeDetail(postInfo: PostInfo) -> DetailModule {
        return DetailViewController(postInfo: postInfo)
    }
}

