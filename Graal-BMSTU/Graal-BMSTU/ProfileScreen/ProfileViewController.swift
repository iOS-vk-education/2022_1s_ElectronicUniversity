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

final class ProfileViewControllerImpl: UIViewController {
    private var authView: AuthView = AuthView()
    private var profileView: ProfileView = ProfileView()

    private let presenter: ProfilePresenter
    private var state: ProfileViewState

    init(presenter: ProfilePresenter) {
        self.presenter = presenter
        state = .auth
        super.init(nibName: nil, bundle: nil)
        presenter.update()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.update()
        setupActions()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ProfileViewControllerImpl: ProfileViewController {

    func showAuthError(description: String?) {
        if let desc = description {
            print(desc)
        } else {
            print("Error")
        }
    }

    func setUserName(str: String) {
        if state == .profile {
            profileView.updateUserName(with: str)
        }
    }

    func setUserGroup(str: String) {
        if state == .profile {
            profileView.updateUserGroup(with: str)
        }
    }

    func setupUI() {
        if state == .profile {
            profileView.setupUI()
        } else {
            authView.setupUI()
        }
    }

    func setupActions() {
        if state == .profile {
            profileView.setupActions([.yourProfile: self.presenter.navigateToProfileDetails])
        } else {
            authView.setupActions(self.presenter.authenticate)
        }
    }

    func setState(to: ProfileViewState) {
        self.state = to
        setupUI()
        setupActions()
        if to == .profile {
            self.view = profileView
        } else {
            self.view = authView
        }
    }
}


