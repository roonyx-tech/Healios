//
//  AuthViewModel.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import RxSwift

final class AuthViewModel: ViewModel {
    struct Input {
        let username: Observable<String?>
        let password: Observable<String?>
        let loginTapped: Observable<Void>
    }
    
    struct Output {
        let response: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let response = input.loginTapped
            .withLatestFrom(Observable.combineLatest(input.username, input.password))
            .flatMap { [unowned self] username, password in
                self.apiService.makeRequest(to: AuthTarget.login(username: username ?? "", password: password ?? ""))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(response: response)
    }
}
