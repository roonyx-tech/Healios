import Swinject
import Alamofire
import Foundation

public protocol ApiServiceAssembly {
    func registerNetworkLayer(in container: Container)
}

public struct ApiServiceAssemblyImpl: ApiServiceAssembly {
    public init() {}
    
    public func registerNetworkLayer(in container: Container) {
        container.register(RequestAdapter.self) {  resolver in
            var adapter = SertLombardRequestAdapter()
            adapter.configService = resolver.resolve(ConfigService.self)!
            return adapter
        }
        
        container.register(RequestRetrier.self) { resolver in
            let retrier = SertRequestRetrierImpl()
            return retrier
        }
        
        container.register(SessionManager.self) { _ in return SessionManager() }
            .initCompleted { resolver, manager in
                manager.startRequestsImmediately = false
                manager.adapter = resolver.resolve(RequestAdapter.self)
                manager.retrier = resolver.resolve(RequestRetrier.self)
            }
            .inObjectScope(.container)
        
        container.register(ApiRequestable.self) { (resolver, target: ApiTarget, stubbed: Bool) in
            if stubbed {
                return StubApiRequest(target: target, behaviour: .afterDelay(1))
            } else {
                let sessionManager = resolver.resolve(SessionManager.self)!
                let configService = resolver.resolve(ConfigService.self)!
                
                return ApiRequest(url: URL(string: target.mainUrl!)!, target: target, manager: sessionManager)
            }
        }
        .inObjectScope(.transient)
        
        container.register(ApiService.self) { resolver in
            let sessionManager = resolver.resolve(SessionManager.self)!
            return ApiServiceImpl(sessionManager: sessionManager) { target, stubbed in
                return resolver.resolve(ApiRequestable.self, arguments: target, stubbed)!
            }
        }
        .inObjectScope(.container)
    }
}
