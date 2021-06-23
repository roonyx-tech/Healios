//
//  ResetPasswordViewModel.swift
//  WeShop
//
//  Created by kairzhan on 6/21/21.
//

import RxSwift

final class ResetPasswordViewModel: ViewModel {
    struct Input {
        let getSmsTapped: Observable<Void>
        let phone: Observable<String>
        let sms: Observable<String>
        let password: Observable<String>
        let changeTapped: Observable<Void>
    }
    
    struct Output {
        let resetTapped: Observable<LoadingSequence<ResponseStatus>>
        let changeTapped: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let resetTapped = input.getSmsTapped
            .withLatestFrom(input.phone)
            .flatMap { [unowned self] phone in
                return apiService.makeRequest(to: AuthTarget.resetPassword(phone: "7\(phone)"))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        let changePassword = input.changeTapped
            .withLatestFrom(Observable.combineLatest(input.phone, input.sms, input.password))
            .flatMap { [unowned self] phone, sms, password in
                return apiService.makeRequest(to: AuthTarget.changePassword(phone: "7\(phone)", sms: sms, password: password))
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(resetTapped: resetTapped, changeTapped: changePassword)
    }
}
