//
//  AuthViewController.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//

import UIKit
import RxSwift

class AuthViewController: UIViewController, ViewHolder, AuthModule {
    var openMain: OpenMain?
    
    typealias RootViewType = AuthView
    
    private let disposeBag = DisposeBag()
    private let viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = AuthView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        bindView()
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(
                                            username: rootView.usernameTextField.rx.text.asObservable(), password: rootView.passwordTextField.rx.text.asObservable(), loginTapped: rootView.signInButton.rx.tap.asObservable()))
        
        let response = output.response.publish()
        
        response.element
            .subscribe(onNext: { [unowned self] response in
                if response.status == 200 {
                    openMain?(response.user?.access_token ?? "")
                }
            }).disposed(by: disposeBag)
        
        response.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        response.connect()
            .disposed(by: disposeBag)
    }
}
