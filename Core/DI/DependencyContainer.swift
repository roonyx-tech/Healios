import Swinject

let assembler = Assembler([DependencyContainerAssembly()])

typealias DependencyContainer = Resolver

public final class DependencyContainerAssembly: Assembly {
    public func assemble(container: Container) {
        
        ApiServiceAssemblyImpl()
            .registerNetworkLayer(in: container)
        
        container.register(ConfigService.self) { _ in
            ConfigServiceImpl()
        }.inObjectScope(.container)
    }
}
