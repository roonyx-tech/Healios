//
//  MainViewModel.swift
//  WeShop
//
//  Created by kairzhan on 6/16/21.
//

import RxSwift

final class MainViewModel: ViewModel {
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let res: Observable<LoadingSequence<ResponseStatus>>
    }
    
    private let apiService: ApiService

    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func transform(input: Input) -> Output {
        let res = input.viewDidLoad
            .flatMap { [unowned self] in
                return apiService.makeRequest(to: AuthTarget.main)
                    .result(ResponseStatus.self)
                    .asLoadingSequence()
            }.share()
        return .init(res: res)
    }
}
