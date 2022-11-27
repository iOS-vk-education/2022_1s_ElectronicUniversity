//
//  AuthView.swift
//  Graal-BMSTU
//
//  Created by Артём on 26.11.2022.
//
import UIKit
import SnapKit
import Rswift
import SFSafeSymbols


typealias LoginAction = (String?, String?) -> Void
typealias SkipAuthAction = () -> Void

final class AuthView: UIView {
    private let bmstuImage = UIImageView(frame: .zero)
    
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
extension AuthView { // actions setup
    func setupLoginAction(_ action: @escaping LoginAction) {
        self.loginAction = action
    }
    
    func setupSkipAuthAction(_ action: @escaping SkipAuthAction) {
        self.skipAuthAction = action
    }
    
}

// MARK: - UI actions
private extension AuthView { // UI actions
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
        self.backgroundColor = .white
        bmstuImage.image = R.image.bmstuLogo()
        loginField.placeholder = R.string.localizable.login_field_placeholder()
        passwordField.placeholder = R.string.localizable.password_field_placeholder()
        loginButtonConf()
        skipAuthButtonConf()
        
        [bmstuImage, loginField, passwordField, loginButton, skipAuthButton].forEach { box in
            self.addSubview(box)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        bmstuImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        loginField.snp.makeConstraints { make in
            make.top.equalTo(bmstuImage.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(20)
            make.top.equalTo(passwordField.snp.bottom).offset(20)
        }
        skipAuthButton.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(20)
            make.top.equalTo(loginButton.snp.bottom).offset(20)
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

