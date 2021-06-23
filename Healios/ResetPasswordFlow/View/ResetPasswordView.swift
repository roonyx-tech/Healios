//
//  ResetPasswordView.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//
import RxSwift
import UIKit

class ResetPasswordView: UIView {
    var passwordTyped: PublishSubject<Void> = .init()
    var invalidPassword: Callback?
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сброс пароля"
        label.font = .bold24
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Пожалуйста, заполните ваш номер. Вам \nбудет отправлено смс с кодом."
        label.font = .regular14
        label.numberOfLines = 0
        return label
    }()
    
    let usernameTextField: PhoneNumberTextField = {
        let textField = PhoneNumberTextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        //textField.font = .regular20
        //textField.placeholder = "0000000000"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let smsTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        textField.font = .systemFont(ofSize: 14)
        textField.placeholder = "СМС код"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let passwordTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        textField.font = .regular20
        textField.isSecureTextEntry = true
        textField.placeholder = "Введите пароль"
        return textField
    }()
    
    let repeatPasswordTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        textField.font = .regular20
        textField.isSecureTextEntry = true
        textField.placeholder = "Повторите пароль"
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        return textField
    }()
    
    let getSmsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить код", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.backgroundColor = .black
        button.tag = 1
        return button
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.backgroundColor = .black
        button.tag = 1
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.backgroundColor = .black
        button.tag = 1
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var formStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameTextField, smsTextField, passwordTextField, repeatPasswordTextField, invalidPasswordLabel, getSmsButton, sendButton, saveButton, signInButton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel, formStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    let invalidPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароли не совпадают"
        label.textColor = .red
        label.font = .regular14
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if passwordTextField.text == repeatPasswordTextField.text {
            saveButton.isEnabled = true
            invalidPasswordLabel.isHidden = true
        } else {
            invalidPasswordLabel.isHidden = false
        }
    }
    
    private func setupInitialLayouts() {
        addSubview(mainStack)
        mainStack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        smsTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        getSmsButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        repeatPasswordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        smsTextField.isHidden = true
        sendButton.isHidden = true
        saveButton.isHidden = true
        passwordTextField.isHidden = true
        repeatPasswordTextField.isHidden = true
        saveButton.isEnabled = false
        invalidPasswordLabel.isHidden = true
    }
}
