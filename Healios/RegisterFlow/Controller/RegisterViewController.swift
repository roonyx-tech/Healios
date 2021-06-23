//
//  RegisterViewController.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//

import UIKit
import RxSwift

class RegisterViewController: UIViewController, ViewHolder, RegisterModule {
    var registerTapped: Callback?
    var backTapped: Callback?
    typealias RootViewType = RegisterView
    
    private let disposeBag = DisposeBag()
    private let viewModel: RegisterViewModel
    private let userSessionStorage: UserSessionStorage
    
    init(viewModel: RegisterViewModel, userSessionStorage: UserSessionStorage) {
        self.viewModel = viewModel
        self.userSessionStorage = userSessionStorage
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = RegisterView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(
        registerTapped: rootView.registerButton.rx.tap.asObservable(),
        name: rootView.usernameTextField.rx.text.asObservable().unwrap(),
                                            phone: rootView.phoneTextField.phoneTextObservable,
        email: rootView.emailTextField.rx.text.asObservable().unwrap(),
        password: rootView.passwordTextField.rx.text.asObservable().unwrap(),
        smsTapped: rootView.getSmsButton.rx.tap.asObservable(),
        sms: rootView.smsTextField.rx.text.asObservable().unwrap(),
        sendTapped: rootView.sendButton.rx.tap.asObservable()))
        
        let sendSms = output.sendTapped.publish()
        
        sendSms.element
            .subscribe(onNext: { [unowned self] res in
                if res.status == 200 {
                    self.rootView.usernameStack.isHidden = false
                    self.rootView.emailStack.isHidden = false
                    self.rootView.passwordStack.isHidden = false
                    self.rootView.registerButton.isHidden = false
                    self.rootView.smsStack.isHidden = true
                    self.rootView.sendButton.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        sendSms.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        sendSms.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        sendSms.connect()
            .disposed(by: disposeBag)
        
        let getSms = output.smsTapped.publish()
        
        getSms.element
            .subscribe(onNext: { [unowned self] res in
                if res.status == 200 {
                    self.rootView.smsStack.isHidden = false
                    self.rootView.sendButton.isHidden = false
                    self.rootView.getSmsButton.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        getSms.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        getSms.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        getSms.connect()
            .disposed(by: disposeBag)
        
        let register = output.registerTapped.publish()
        
        register.element
            .subscribe(onNext: { [unowned self] res in
                if res.status == 200 {
                    self.userSessionStorage.save(accessToken: res.user?.access_token)
                    self.registerTapped?()
                }
            }).disposed(by: disposeBag)
        
        register.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        register.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        register.connect()
            .disposed(by: disposeBag)
        
        rootView.signInButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        rootView.backButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.backTapped?()
            }).disposed(by: disposeBag)
    }
}
