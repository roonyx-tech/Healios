import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator {
    override init(router: Router) {
        super.init(router: router)
    }
    
    override func start() {
        showMain()
    }
    
    private func showAuth() {
        var module = makeAuth()
        module.openMain = { [unowned self] in
            self.showMain()
        }
        router.setRootModule(module)
    }
    
    private func showMain() {
        var module = makeMain()
        module.loginTapped = { [unowned self] in
            self.showAuth()
        }
        router.setRootModule(module)
    }
    
    func makeAuth() -> AuthModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let viewModel = AuthViewModel(apiService: apiService)
        let userSessionStorage = assembler.resolver.resolve(UserSessionStorage.self)!
        return AuthViewController(viewModel: viewModel, userSessionStorage: userSessionStorage)
    }
    
    func makeMain() -> MainModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let viewModel = MainViewModel(apiService: apiService)
        let userSessionStorage = assembler.resolver.resolve(UserSessionStorage.self)!
        return MainViewContorller(viewModel: viewModel, userSessionStorage: userSessionStorage)
    }
}

