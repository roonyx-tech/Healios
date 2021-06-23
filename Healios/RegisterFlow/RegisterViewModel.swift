//
//  RegisterViewModel.swift
//  WeShop
//
//  Created by kairzhan on 6/21/21.
//

import RxSwift

final class RegisterViewModel: ViewModel {
    struct Input {
        let registerTapped: Observable<Void>
        let name: Observable<String>
        let phone: Observable<String>
        let email: Observable<String>
        let password: Observable<String>
        let smsTapped: Observable<Void>
        let sms: Observable<String>
        let sendTapped: Observable<Void>
    }
    
    struct Output {
        let registerTapped: Observable<LoadingSequence<ResponseStatus>>
        let smsTapped: Observable<LoadingSequence<ResponseStatus>>
        let sendTapped: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let registerTapped = input.registerTapped
            .withLatestFrom(Observable.combineLatest(input.name, input.phone, input.email, input.password))
            .flatMap { [unowned self] name, phone, email, password in
                return apiService.makeRequest(to: AuthTarget.register(name: name, phone: "7\(phone)", email: email, password: password))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        let smsTapped = input.smsTapped
            .withLatestFrom(input.phone)
            .flatMap { [unowned self] phone in
                return apiService.makeRequest(to: AuthTarget.sms(phone: "7\(phone)"))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        let sendTapped = input.sendTapped
            .withLatestFrom(Observable.combineLatest(input.phone, input.sms))
            .flatMap { [unowned self] phone, sms in
                return apiService.makeRequest(to: AuthTarget.activateSms(phone: "7\(phone)", sms: sms))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(registerTapped: registerTapped, smsTapped: smsTapped, sendTapped: sendTapped)
    }
}
