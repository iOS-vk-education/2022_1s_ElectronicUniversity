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

extension ProfileView { // data updates
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

extension ProfileView { // actions setups
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


private extension ProfileView { // UI
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
            // make.width.equalTo(100)
            // height?
        }
        
        userGroupLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(userNameLabel.snp.bottom).offset(30)
            // make.width.equalTo(100)
            // height?
        }
        
        profileDetailButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(userGroupLabel.snp.bottom).offset(30)
            // make.width.equalTo(100)
            // height?
        }
        
        settingsButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(profileDetailButton.snp.bottom).offset(30)
            // make.width.equalTo(100)
            // height?
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(settingsButton.snp.bottom).offset(30)
            // make.width.equalTo(100)
            // height?
        }
        
        
    }

    func profileDetailButtonConf() {
        var config = UIButton.Configuration.filled()
        config.title = R.string.localizable.your_profile_button_title()
        // ...
        profileDetailButton.configuration = config
        profileDetailButton.addTarget(self, action: #selector(self.profileDetailButtonPressed), for: .touchUpInside)

    }

    func settingsButtonConf() {
        var config = UIButton.Configuration.filled()
        config.title = R.string.localizable.settings_button_title()
        // ...
        settingsButton.configuration = config
        settingsButton.addTarget(self, action: #selector(self.settingsButtonPressed), for: .touchUpInside)

    }
    
    func logoutButtonConf() {
        var config = UIButton.Configuration.filled()
        config.title = R.string.localizable.signout_button_title()
        // ...
        logoutButton.configuration = config
        logoutButton.addTarget(self, action: #selector(self.logoutButtonPressed), for: .touchUpInside)

    }
}


private extension ProfileView { // UI actions
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
