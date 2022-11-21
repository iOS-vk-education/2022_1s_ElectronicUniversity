//
//  ProfileView.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//

import UIKit
import SnapKit
import SFSafeSymbols

typealias ProfileDetailAction = () -> Void
typealias SettingsAction = () -> Void

final class ProfileView: UIView {
    private let userLogo = UIImageView(frame: .zero)
    private let userNameLabel = UILabel(frame: .zero)
    private let userGroupLabel = UILabel(frame: .zero)
    private let profileDetailButton = UIButton(frame: .zero)
    private let settingsButton = UIButton(frame: .zero)

    private var profileDetailAction: ProfileDetailAction?
    private var settingsAction: SettingsAction?
}

extension ProfileView {
    func updateUserGroup(with: String) {
        self.userGroupLabel.text = with
    }

    func updateUserName(with: String) {
        self.userNameLabel.text = with
    }

    func updateUserLogo(with: UIImage) {
        self.userLogo.image = with
    }

}

extension ProfileView {
    func setupUI() {
        userLogo.image = UIImage(systemSymbol: .personCircle)
        profileDetailButton.configuration = profileDetailButtonConf()
        settingsButton.configuration = settingsButtonConf()
        [userLogo, userNameLabel, userGroupLabel, profileDetailButton, settingsButton].forEach {
            box in
            self.addSubview(box)
        }
        setupConstraints()
    }

    private func setupConstraints() {

    }

    private func profileDetailButtonConf() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = R.string.localizable.your_profile_button_title()
        // ...
        return config
    }

    private func settingsButtonConf() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = R.string.localizable.setting_button_title()
        // ...
        return config
    }
}

extension ProfileView {
    func setProfileDetailButtonAction(_ action: @escaping ProfileDetailAction) {
        self.profileDetailAction = action
    }

    func setSettingsButtonAction(_ action: @escaping SettingsAction) {
        self.settingsAction = action
    }

    @objc private func profileDetailButtonPressed() {
        self.profileDetailAction?()
    }

    @objc private func settingsButtonPressed() {
        self.settingsAction?()
    }
}


typealias LoginAction = (String?, String?) -> Void

final class AuthView: UIView {
    private let bmstuImage = UIImageView(frame: .zero)
    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)
    private let loginButton = UIButton(frame: .zero)

    private let continueWithoutLoginButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!

    private var loginAction: LoginAction?
}


extension AuthView {
    // actions
    func setupActions(_ action: @escaping LoginAction) {
        self.loginAction = action
    }

    @objc private func loginButtonPressed() {
        if let action = self.loginAction {
            action(loginField.text, passwordField.text)
        }
    }
}

extension AuthView {
    private func createLoginButtonConfig() -> UIButton.Configuration {
        var loginButtonConfig = UIButton.Configuration.filled()
        loginButtonConfig.buttonSize = .large
        loginButtonConfig.cornerStyle = .medium
        loginButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
            return outgoing
        }
        loginButtonConfig.title = R.string.localizable.login_button_text()
        loginButtonConfig.titlePadding = 5
        loginButtonConfig.image = UIImage(systemSymbol: .chevronRight)
        loginButtonConfig.imagePadding = 5
        loginButtonConfig.imagePlacement = .trailing
        loginButtonConfig.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)
        return loginButtonConfig
    }

    func setupUI() {
        bmstuImage.image = R.image.bmstuLogo()
        loginField.placeholder = R.string.localizable.login_field_placeholder()
        passwordField.placeholder = R.string.localizable.password_field_placeholder()
        loginButton.configuration = createLoginButtonConfig()
        loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
        [bmstuImage, loginField, passwordField, loginButton, continueWithoutLoginButton].forEach { box in
            self.addSubview(box)
        }
        self.setupConstraints()
    }

    private func setupConstraints() {
        bmstuImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 100))
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
    }
}

