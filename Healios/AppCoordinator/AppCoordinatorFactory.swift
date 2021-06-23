//
//  AppCoordinatorFactory.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//

import Swinject

class AppCoordinatorFactory {
    private let container: DependencyContainer

    init(container: DependencyContainer) {
        self.container = container
    }
    
    func makeMain() -> MainModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let userSessionStorage = assembler.resolver.resolve(UserSessionStorage.self)!
        let viewModel = MainViewModel(apiService: apiService)
        return MainViewContorller(viewModel: viewModel, userSessionStorage: userSessionStorage)
    }
    
    func makeAuth() -> AuthModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let userSessionStorage = assembler.resolver.resolve(UserSessionStorage.self)!
        let viewModel = AuthViewModel(apiService: apiService)
        return AuthViewController(viewModel: viewModel, userSessionStorage: userSessionStorage)
    }
    
    func makeRegister() -> RegisterModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let viewModel = RegisterViewModel(apiService: apiService)
        let userSessionStorage = assembler.resolver.resolve(UserSessionStorage.self)!
        return RegisterViewController(viewModel: viewModel, userSessionStorage: userSessionStorage)
    }
    
    func makeResetPassword() -> ResetPasswordModule {
        let apiService = assembler.resolver.resolve(ApiService.self)!
        let viewModel = ResetPasswordViewModel(apiService: apiService)
        return ResetPasswordViewController(viewModel: viewModel)
    }
}
