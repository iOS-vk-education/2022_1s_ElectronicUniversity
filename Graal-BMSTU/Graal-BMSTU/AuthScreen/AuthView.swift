////
////  AuthView.swift
////  Graal-BMSTU
////
////  Created by Артём on 03.11.2022.
////
//
//import UIKit
//import SnapKit
//import Rswift
//import SFSafeSymbols
//
//
//typealias LoginAction = (String?, String?) -> Void
//
//
//final class AuthView: UIView
//{
//    private let bmstuImage = UIImageView(frame: .zero)
//    private let loginField = UITextField(frame: .zero)
//    private let passwordField = UITextField(frame: .zero)
//    private let loginButton = UIButton(frame: .zero)
//    //    private let notificationView = GraalNotification(frame: .zero)
//    
//    private let continueWithoutLoginButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!
//    
//    private var loginAction: LoginAction?
//}
//
//extension AuthView
//{
//    // actions
//    func setLoginAction(_ action: @escaping LoginAction)
//    {
//        self.loginAction = action
//    }
//    
//    @objc private func loginButtonPressed()
//    {
//        if let action = self.loginAction { action(loginField.text, passwordField.text) }
//    }
//}
//
//extension AuthView
//{
//    // UI
//    private func createLoginButtonConfig() -> UIButton.Configuration {
//        var loginButtonConfig = UIButton.Configuration.filled()
//        loginButtonConfig.buttonSize = .large
//        loginButtonConfig.cornerStyle = .medium
//        loginButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer
//        { incoming in
//            var outgoing = incoming
//            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
//            return outgoing
//        }
//        loginButtonConfig.title = R.string.localizable.login_button_text()
//        loginButtonConfig.titlePadding = 5
//        loginButtonConfig.image = UIImage(systemSymbol: .chevronRight)
//        loginButtonConfig.imagePadding = 5
//        loginButtonConfig.imagePlacement = .trailing
//        loginButtonConfig.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
//        return loginButtonConfig
//    }
//    
//    func setupUI()
//    {
//        bmstuImage.image = R.image.bmstuLogo()
//        loginField.placeholder = R.string.localizable.login_field_placeholder()
//        passwordField.placeholder = R.string.localizable.password_field_placeholder()
//        
//        loginButton.configuration = createLoginButtonConfig()
//        loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
//        [bmstuImage, loginField, passwordField, loginButton, continueWithoutLoginButton].forEach
//        { box in
//            self.addSubview(box)
//        }
//        self.setupConstraints()
//    }
//    
//    private func setupConstraints()
//    {
//        bmstuImage.snp.makeConstraints
//        { make in
//            make.centerX.equalToSuperview()
//            make.size.equalTo(CGSize(width: 100, height: 100))
//            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
//        }
//        loginField.snp.makeConstraints
//        { make in
//            make.top.equalTo(bmstuImage.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//        }
//        passwordField.snp.makeConstraints
//        { make in
//            make.top.equalTo(loginField.snp.bottom).offset(20)
//            make.centerX.equalToSuperview()
//        }
//        loginButton.snp.makeConstraints { make in
//            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(20)
//            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(20)
//            make.top.equalTo(passwordField.snp.bottom).offset(20)
//        }
//    }
//}
