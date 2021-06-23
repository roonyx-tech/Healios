//
//  RegisterView.swift
//  WeShop
//
//  Created by kairzhan on 6/18/21.
//

import UIKit

class RegisterView: UIView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = .bold24
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Полное имя"
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
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Номер"
        label.font = .regular20
        return label
    }()
    
    let phoneTextField: PhoneNumberTextField = {
        let textField = PhoneNumberTextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        //textField.font = .regular20
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Эл. адрес"
        label.font = .regular20
        return label
    }()
    
    let emailTextField: TextField = {
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
    
    let smsLabel: UILabel = {
        let label = UILabel()
        label.text = "Смс код"
        label.font = .regular20
        return label
    }()
    
    let smsTextField: TextField = {
        let textField = TextField()
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 6
        textField.font = .systemFont(ofSize: 14)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Регистрация", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.backgroundColor = .black
        return button
    }()
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Есть аккаунт? Войти", for: .normal)
        button.titleLabel?.font = .regular20
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "arrowLeft")?.withRenderingMode(.alwaysTemplate)
        button.imageView?.tintColor = .black
        button.setTitle("Назад", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.regular20
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    lazy var phoneStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [phoneLabel, phoneTextField])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var smsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [smsLabel, smsTextField])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var usernameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var emailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
    }()
    
    lazy var passwordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 4
        return stack
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
    
    lazy var formStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameStack, phoneStack, smsStack, emailStack, passwordStack, getSmsButton, sendButton, registerButton, signInButton])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [backButton, titleLabel, formStack])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
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
        addSubview(mainStack)
        mainStack.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        smsTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        getSmsButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        sendButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.height.equalTo(40)
        }
    }
    
    private func configureView() {
        usernameStack.isHidden = true
        emailStack.isHidden = true
        passwordStack.isHidden = true
        smsStack.isHidden = true
        sendButton.isHidden = true
        registerButton.isHidden = true
    }
}
