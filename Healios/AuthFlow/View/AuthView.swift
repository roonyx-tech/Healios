//
//  AuthView.swift
//  Healios
//
//  Created by kairzhan on 5/31/21.
//
import SnapKit
import UIKit

class AuthView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.font = .bold24
        return label
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "arrowLeft")?.withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = .black
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.regular20
        button.setImage(image, for: .normal)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер телефона"
        label.font = .regular20
        return label
    }()
    
    let usernameTextField: PhoneNumberTextField = {
        let textField = PhoneNumberTextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        //textField.font = .regular20
        //textField.keyboardType = .numberPad
        textField.returnKeyType = .done
        return textField
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Пароль"
        label.font = .regular20
        return label
    }()
    
    let passwordTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        textField.isSecureTextEntry = true
        textField.font = .regular20
        return textField
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("ВОЙТИ", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.backgroundColor = .black
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Нет аккаунта? Зарегистрироваться", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Забыли пароль?", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayouts()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInitialLayouts() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(-120)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.top).offset(-50)
            make.left.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
        }
        
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        addSubview(resetButton)
        resetButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(resetButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(40)
        }
        
        addSubview(registerButton)
        registerButton.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
    }
    
    private func configureView() {
        
    }
}

class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
