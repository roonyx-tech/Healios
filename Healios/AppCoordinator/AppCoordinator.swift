import Swinject
import RxSwift

final class AppCoordinator: BaseCoordinator {
    private let coordinatorFactory: AppCoordinatorFactory
    
    override init(router: Router, container: DependencyContainer) {
        coordinatorFactory = AppCoordinatorFactory(container: container)
        super.init(router: router, container: container)
    }
    
    override func start() {
        showMain()
    }
    
    private func showAuth() {
        var module = coordinatorFactory.makeAuth()
        module.openMain = { [unowned self] in
            self.showMain()
        }
        module.backTapped = { [unowned self] in
            self.showMain()
        }
        module.registerTapped = { [unowned self] in
            self.showRegister()
        }
        module.resetPasswordTapped = { [unowned self] in
            self.showResetPassword()
        }
        router.setRootModule(module)
    }
    
    private func showMain() {
        var module = coordinatorFactory.makeMain()
        module.loginTapped = { [unowned self] in
            self.showAuth()
        }
        router.setRootModule(module)
    }
    
    private func showRegister() {
        var module = coordinatorFactory.makeRegister()
        module.backTapped = { [unowned self] in
            self.showMain()
        }
        module.registerTapped = { [unowned self] in
            self.showMain()
        }
        router.push(module)
    }
    
    private func showResetPassword() {
        var module = coordinatorFactory.makeResetPassword()
        module.saved =  { [unowned self] in
            self.showAuth()
        }
        router.push(module)
    }
}

