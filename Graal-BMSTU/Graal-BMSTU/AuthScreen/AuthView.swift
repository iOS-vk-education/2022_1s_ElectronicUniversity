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
    private let hint = UILabel(frame: .zero)
    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)
    private let loginButton = UIButton(frame: .zero)
    private let skipAuthButton = UIButton(
            frame: .zero) // только при первом запуске есть такая кнопка!

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

    func setLoginFieldDelegate(_ delegate: UITextFieldDelegate) {
        loginField.delegate = delegate;
    }

    func setPasswordFieldDelegate(_ delegate: UITextFieldDelegate) {
        passwordField.delegate = delegate;
    }

    func passwordFieldResignFirstResponder() -> Bool {
        passwordField.resignFirstResponder()
    }

    func loginFieldResignFirstResponder() -> Bool {
        loginField.resignFirstResponder()
    }


}

// MARK: - UI actions
private extension AuthView {
    @objc func loginButtonPressed() {
        self.loginAction?(loginField.text, passwordField.text)
    }

    @objc func skipAuthButtonPressed() {
        self.skipAuthAction?()
    }
}

// MARK: - UI
private extension AuthView {
    func setupUI() {
        self.backgroundColor = .white
        bmstuImage.image = R.image.bmstuLogo()
        loginFieldConf()
        passwordFieldConf()
        loginButtonConf()
        skipAuthButtonConf()
        hintLabelConf()

        var elems = [bmstuImage, loginField, passwordField, loginButton, hint]
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
            make.size.equalTo(150)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        hint.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(30)
            make.top.equalTo(bmstuImage.snp.bottom).offset(25)
            make.height.equalTo(50)
        }
        loginField.snp.makeConstraints { make in
            make.top.equalTo(hint.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(25)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(25)
        }
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(25)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(25)
        }
        loginButton.snp.makeConstraints { make in
            make.left.equalTo(self.safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(self.safeAreaLayoutGuide.snp.right).inset(30)
            make.top.equalTo(passwordField.snp.bottom).offset(25)
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
        var config = basicButtonConf(button: loginButton)
        config.title = R.string.localizable.login_button_text()
        config.image = UIImage(systemSymbol: .chevronRight)
        loginButton.configuration = config
        loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
    }

    func skipAuthButtonConf() {
        var config = basicButtonConf(button: skipAuthButton)
        config.title = R.string.localizable.skip_auth_button_text()
        config.image = UIImage(systemSymbol: .rectanglePortraitAndArrowRight)
        skipAuthButton.configuration = config
        skipAuthButton.addTarget(self, action: #selector(self.skipAuthButtonPressed),
                for: .touchUpInside)
    }

    func loginFieldConf() {
        basicTextFieldConf(field: loginField)
        loginField.placeholder = R.string.localizable.login_field_placeholder()
    }

    func passwordFieldConf() {
        basicTextFieldConf(field: passwordField)
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = R.string.localizable.password_field_placeholder()
    }

    func hintLabelConf() {
        hint.text = R.string.localizable.hint_label_text()
        hint.textAlignment = .center
        hint.numberOfLines = 0
        //        hint.font = UIFont.boldSystemFont(ofSize: 25) // почему два шрифта?
        hint.font = UIFont.systemFont(ofSize: 20)
    }
}
