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


class ProfileView: UIView {
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
typealias SkipAuthAction = () -> Void

final class AuthView: UIView {
    private let bmstuImage = UIImageView(frame: .zero)

    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)

    private let loginButton = UIButton(frame: .zero)
    private let skipAuthButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!

    private var loginAction: LoginAction?
    private var skipAuthAction: SkipAuthAction?
}


extension AuthView {
    // actions
    func setupLoginAction(_ action: @escaping LoginAction) {
        self.loginAction = action
    }

    @objc private func loginButtonPressed() {
        if let action = self.loginAction {
            action(loginField.text, passwordField.text)
        } else {
            print("No login action!")
        }
    }

    func setupSkipAuthAction(_ action: @escaping SkipAuthAction) {
        self.skipAuthAction = action
    }

    @objc private func skipAuthButtonPressed() {
        if let action = self.skipAuthAction {
            action()
        } else {
            print("No skipAuth action!")
        }
    }
}

extension AuthView {
    private func createLoginButtonConfig() -> UIButton.Configuration {
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
        return config
    }

    private func createSkipAuthButton() -> UIButton.Configuration {
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
        return config
    }

    func setupUI() {
        self.backgroundColor = .white
        bmstuImage.image = R.image.bmstuLogo()
        loginField.placeholder = R.string.localizable.login_field_placeholder()
        passwordField.placeholder = R.string.localizable.password_field_placeholder()

        loginButton.configuration = createLoginButtonConfig()
        loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)

        skipAuthButton.configuration = createSkipAuthButton()
        skipAuthButton.addTarget(self, action: #selector(self.skipAuthButtonPressed), for: .touchUpInside)
        [bmstuImage, loginField, passwordField, loginButton, skipAuthButton].forEach { box in
            self.addSubview(box)
        }
        self.setupConstraints()
    }

    private func setupConstraints() {
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
}

