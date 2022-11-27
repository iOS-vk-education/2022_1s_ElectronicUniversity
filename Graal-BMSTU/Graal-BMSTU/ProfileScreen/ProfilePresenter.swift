//
//  ProfilePresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

final class ProfilePresenterImpl: ProfilePresenter {
    private weak var vc: ProfileViewControllerProtocol?
    private var service: AuthService?
    private let coordinator: ProfileRouter

    init(router: ProfileRouter, service: AuthService) {
        self.coordinator = router
        self.service = service
    }

    func setVC(vc: ProfileViewControllerProtocol) {
        self.vc = vc
    }

    func authenticate(username: String?, password: String?) {
        if let username = username, let password = password {
            if let _ = service?.authenticate(login: username, password: password) {
                update()
            } else {
                vc?.showAuthError(description: "Auth error")
            }
        } else {
            vc?.showAuthError(description: "Incorrect input")
        }
    }

    func skipAuthentication() {
        AppCoordinator.setNotFirstLaunch()
        // ... notification center
        // ... restart appcoordinator or just change flow coordinator
    }

    func update() {
        let user = service?.getUserData()
        if let user = user {
            vc?.setUserName(str: user.name + " " + user.familyName)
            vc?.setUserGroup(str: user.group)
            vc?.setState(to: .profile)
        } else {
            vc?.setState(to: .auth)
        }
    }

    func logout() {
        service?.logout()
        update()
    }

    func navigateToProfileDetails() {
        coordinator.navigateToProfileDetails()
    }

    func navigateToSettings() {
         coordinator.navigateToSettings()
    }
}
