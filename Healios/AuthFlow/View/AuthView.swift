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
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя пользователя или email"
        label.font = .regular20
        return label
    }()
    
    let usernameTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        textField.font = .regular20
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
            make.centerY.equalToSuperview().offset(-100)
            make.left.equalToSuperview().inset(30)
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
        
        addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(100)
            make.height.equalTo(40)
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
