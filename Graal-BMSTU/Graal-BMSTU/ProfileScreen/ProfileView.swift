//
//  ProfileView.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//

import UIKit
import SnapKit
import SFSafeSymbols
import RswiftResources

typealias ProfileDetailAction = () -> Void
typealias SettingsAction = () -> Void
typealias LogoutAction = () -> Void

final class ProfileView: UIView {
    private let userLogo = UIImageView(frame: .zero)
    private let userNameLabel = UILabel(frame: .zero)
    private let userGroupLabel = UILabel(frame: .zero)
    private let profileDetailButton = UIButton(frame: .zero)
    private let settingsButton = UIButton(frame: .zero)
    private let logoutButton = UIButton(frame: .zero)

    private var profileDetailAction: ProfileDetailAction?
    private var settingsAction: SettingsAction?
    private var logoutAction: LogoutAction?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - data updates
extension ProfileView {
    func updateUserGroup(with group: String) {
        self.userGroupLabel.text = group
    }

    func updateUserName(with name: String) {
        self.userNameLabel.text = name
    }

    func updateUserLogo(with image: UIImage) {
        self.userLogo.image = image
    }
}

// MARK: - actions setups
extension ProfileView {
    func setProfileDetailButtonAction(_ action: @escaping ProfileDetailAction) {
        self.profileDetailAction = action
    }

    func setSettingsButtonAction(_ action: @escaping SettingsAction) {
        self.settingsAction = action
    }

    func setLogoutAction(_ action: @escaping LogoutAction) {
        self.logoutAction = action
    }
}

// MARK: - UI
private extension ProfileView {
    func setupUI() {
        self.backgroundColor = .white
        userLogo.image = UIImage(systemSymbol: .personCircle)
        profileDetailButtonConf()
        settingsButtonConf()
        logoutButtonConf()

        [userLogo, userNameLabel, userGroupLabel, profileDetailButton, settingsButton, logoutButton].forEach {
            box in
            self.addSubview(box)
        }
        setupConstraints()
    }

    func setupConstraints() {
        userLogo.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.size.equalTo(50)
        }

        userNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(userLogo.snp.bottom).offset(30)
        }

        userGroupLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(userNameLabel.snp.bottom).offset(30)
        }

        profileDetailButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(userGroupLabel.snp.bottom).offset(30)
        }

        settingsButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(profileDetailButton.snp.bottom).offset(30)
        }

        logoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(settingsButton.snp.bottom).offset(30)
        }
    }

    // MARK: - button configs
    func profileDetailButtonConf() {
        var config = basicButtonConf(button: profileDetailButton)
        config.title = R.string.localizable.your_profile_button_title()
        profileDetailButton.configuration = config
        profileDetailButton.addTarget(self, action: #selector(self.profileDetailButtonPressed),
                for: .touchUpInside)

    }

    func settingsButtonConf() {
        var config = basicButtonConf(button: settingsButton)
        config.title = R.string.localizable.settings_button_title()
        settingsButton.configuration = config
        settingsButton.addTarget(self, action: #selector(self.settingsButtonPressed),
                for: .touchUpInside)

    }

    func logoutButtonConf() {
        var config = basicButtonConf(button: logoutButton)
        config.title = R.string.localizable.signout_button_title()
        logoutButton.configuration = config
        logoutButton.addTarget(self, action: #selector(self.logoutButtonPressed),
                for: .touchUpInside)

    }
}

// MARK: - UI actions
private extension ProfileView {
    @objc func profileDetailButtonPressed() {
        self.profileDetailAction?()
    }

    @objc func settingsButtonPressed() {
        self.settingsAction?()
    }

    @objc func logoutButtonPressed() {
        self.logoutAction?()
    }
}
