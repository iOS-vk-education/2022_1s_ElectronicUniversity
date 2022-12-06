//
//  ProfileViewController.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

enum ProfileViewState {
    case profile
    case auth
}

final class ProfileViewController: UIViewController {
    private var authView: AuthView = AuthView(frame: .zero)
    private var profileView: ProfileView = ProfileView(frame: .zero)

    private let presenter: ProfilePresenter
    private var state: ProfileViewState?

    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
        self.presenter.setVC(vc: self)
        self.presenter.update()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

extension ProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        authView.passwordFieldResignFirstResponder() || authView.loginFieldResignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension ProfileViewController: ProfileViewControllerProtocol {
    func showAuthError(description: String?) {
        // placeholder
        if let desc = description {
            print(desc)
        } else {
            print("Error")
        }
    }

    func setUserName(str: String) {
        profileView.updateUserName(with: str)
    }

    func setUserGroup(str: String) {
        profileView.updateUserGroup(with: str)
    }

    func setupActions() {
        profileView.setProfileDetailButtonAction(self.presenter.navigateToProfileDetails)
        profileView.setLogoutAction(self.presenter.logout)
        profileView.setSettingsButtonAction(self.presenter.navigateToSettings)
        authView.setupLoginAction(self.presenter.authenticate)
        authView.setupSkipAuthAction(self.presenter.skipAuthentication)
        authView.setLoginFieldDelegate(self)
        authView.setPasswordFieldDelegate(self)
    }

    func setState(toView to: ProfileViewState) {
        self.state = to
        switch to {
        case .auth:
            authViewRefresh()
            self.view = authView
        case .profile:
            self.view = profileView
        }
    }

    func authViewRefresh() {
        self.authView = AuthView(frame: .zero)
        setupActions()
    }
}
