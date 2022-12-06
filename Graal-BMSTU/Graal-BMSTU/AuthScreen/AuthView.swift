//
//  AuthView.swift
//  Graal-BMSTU
//
//  Created by Артём on 26.11.2022.
//

import UIKit
import SnapKit
import RswiftResources
import SFSafeSymbols

typealias LoginAction = (String?, String?) -> Void
typealias SkipAuthAction = () -> Void

final class AuthView: UIView {
    private let bmstuImage = UIImageView(frame: .zero)
    
    private let label = UILabel(frame: .zero)

    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)

    private let loginButton = UIButton(frame: .zero)
    private let skipAuthButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!

    private var loginAction: LoginAction?
    private var skipAuthAction: SkipAuthAction?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - actions setup

extension AuthView {
    func setupLoginAction(_ action: @escaping LoginAction) {
        self.loginAction = action
    }

    func setupSkipAuthAction(_ action: @escaping SkipAuthAction) {
        self.skipAuthAction = action
    }
}

// MARK: - UI actions

private extension AuthView {
    @objc func loginButtonPressed() {
        if let action = self.loginAction {
            action(loginField.text, passwordField.text)
        } else {
            print("No login action!")
        }
    }

    @objc func skipAuthButtonPressed() {
        if let action = self.skipAuthAction {
            action()
        } else {
            print("No skipAuth action!")
        }
    }
}

// MARK: - UI

private extension AuthView {
    func setupUI() {
        
        self.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        bmstuImage.image = R.image.bmstuLogo()
        
        loginField.placeholder = R.string.localizable.login_field_placeholder()
        passwordField.placeholder = R.string.localizable.password_field_placeholder()
        loginField.clearButtonMode = .whileEditing
        passwordField.clearButtonMode = .whileEditing
        loginField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordField.borderStyle = UITextField.BorderStyle.roundedRect
        loginField.layer.cornerRadius = 2.0
        passwordField.layer.cornerRadius = 2.0
        loginField.borderStyle = UITextField.BorderStyle.none
        passwordField.borderStyle = UITextField.BorderStyle.none
        loginField.layer.masksToBounds = false
        passwordField.layer.masksToBounds = false
        loginField.layer.borderWidth = 0.0;
        loginField.layer.borderColor = CGColor.init(red: 255/255, green: 250/255, blue: 250/255, alpha: 1)
        passwordField.layer.borderColor = CGColor.init(red: 255/255, green: 250/255, blue: 250/255, alpha: 1);
        passwordField.layer.borderWidth = 0.0;
        passwordField.layer.shadowRadius = 5.0
        passwordField.layer.shadowColor = CGColor.init(red: 177/255, green: 174/255, blue: 168/255, alpha: 0.8)
        loginField.layer.shadowColor = CGColor.init(red: 177/255, green: 174/255, blue: 168/255, alpha: 0.8)
        passwordField .layer.shadowOffset = CGSizeMake(0.0, 0.0)
        passwordField.layer.shadowOpacity = 0.9
        loginField.layer.shadowRadius = 5.0
             //passwordField.layer.shadowColor = UIColor.lightGray
        loginField .layer.shadowOffset = CGSizeMake(0.0, 0.0)
        loginField.layer.shadowOpacity = 0.9
        loginField.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        passwordField.backgroundColor = .init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
      
        
        loginButton.layer.cornerRadius = 20
        skipAuthButton.layer.cornerRadius = 20
        
        loginButtonConf()
        skipAuthButtonConf()
        
//        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.numberOfLines = 2;
        label.text = "Введите логин/пароль от учетной   записи университета"
        label.textAlignment = .center
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        label.font = UIFont.boldSystemFont (ofSize: 25)
        label.font = UIFont.systemFont (ofSize: 20)
        
        var elems = [bmstuImage, loginField, passwordField, loginButton, label]
        if AppCoordinator.isFirstLaunch() {
            elems.append(skipAuthButton)
        }
        elems.forEach { box in
            self.addSubview(box)
        }
        setupConstraints()
    }

    func setupConstraints() {
        bmstuImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        label.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(30)
            make.top.equalTo(bmstuImage.snp.bottom).offset(35)
            make.height.equalTo(50)
        }
        loginField.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(55)
            make.centerX.equalToSuperview()
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(30)
            make.top.equalTo(passwordField.snp.bottom).offset(115)
            make.height.equalTo(50)
        }
        if AppCoordinator.isFirstLaunch() {
            skipAuthButton.snp.makeConstraints { make in
                make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(30)
                make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(30)
                make.top.equalTo(loginButton.snp.bottom).offset(25)
                make.height.equalTo(50)
            }
        }
       
                 
    }
    
    
    // MARK: - button configs

    func loginButtonConf() {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        config.title = R.string.localizable.login_button_text()
        config.titlePadding = 5
        config.image = UIImage(systemSymbol: .chevronRight)
        config.imagePadding = 5
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        self.loginButton.configuration = config
        loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
    }

    func skipAuthButtonConf() {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .large
        config.cornerStyle = .medium
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        config.title = R.string.localizable.skip_auth_button_text()
        config.titlePadding = 5
        config.image = UIImage(systemSymbol: .rectanglePortraitAndArrowRight)
        config.imagePadding = 5
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        self.skipAuthButton.configuration = config
        skipAuthButton.addTarget(self, action: #selector(self.skipAuthButtonPressed), for: .touchUpInside)
    }
}
