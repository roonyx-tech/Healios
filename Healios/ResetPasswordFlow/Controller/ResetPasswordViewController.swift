//
//  ResetPasswordViewController.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//

import UIKit
import RxSwift

class ResetPasswordViewController: UIViewController, ViewHolder, ResetPasswordModule {
    var saved: Callback?
    
    typealias RootViewType = ResetPasswordView
    private let disposeBag = DisposeBag()
    private let viewModel: ResetPasswordViewModel
    
    override func loadView() {
        view = ResetPasswordView()
    }
    
    init(viewModel: ResetPasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        let output = viewModel.transform(input: .init(getSmsTapped: rootView.getSmsButton.rx.tap.asObservable(), phone: rootView.usernameTextField.phoneTextObservable, sms: rootView.smsTextField.rx.text.asObservable().unwrap(), password: rootView.passwordTextField.rx.text.asObservable().unwrap(), changeTapped: rootView.saveButton.rx.tap.asObservable()))
        
        let changePassword = output.changeTapped.publish()
        
        changePassword.element
            .subscribe(onNext: { [unowned self] res in
                if res.status == 200 {
                    showSuccessAlert {
                        self.saved?()
                    }
                }
            }).disposed(by: disposeBag)
        
        changePassword.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        changePassword.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        changePassword.connect()
            .disposed(by: disposeBag)
        
        let resetTapped = output.resetTapped.publish()
        
        resetTapped.element
            .subscribe(onNext: { [unowned self] res in
                if res.status == 200 {
                    self.rootView.getSmsButton.isHidden = true
                    self.rootView.sendButton.isHidden = false
                    self.rootView.smsTextField.isHidden = false
                }
            }).disposed(by: disposeBag)
        
        resetTapped.loading
            .bind(to: ProgressView.instance.rx.loading)
            .disposed(by: disposeBag)
        
        resetTapped.errors
            .bind(to: rx.error)
            .disposed(by: disposeBag)
        
        resetTapped.connect()
            .disposed(by: disposeBag)
        
        rootView.signInButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        rootView.sendButton.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.rootView.subTitleLabel.text = "Введите новый пароль"
                self.rootView.usernameTextField.isHidden = true
                self.rootView.smsTextField.isHidden = true
                self.rootView.passwordTextField.isHidden = false
                self.rootView.repeatPasswordTextField.isHidden = false
                self.rootView.sendButton.isHidden = true
                self.rootView.saveButton.isHidden = false
            }).disposed(by: disposeBag)
        
        rootView.invalidPassword = { [unowned self] in
            self.showSimpleAlert(title: "Упс", message: "Пароли не совпадают")
        }
    }
}
