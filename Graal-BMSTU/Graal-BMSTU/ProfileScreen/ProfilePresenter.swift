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
    private let router: ProfileRouter

    init(router: ProfileRouter, service: AuthService) {
        self.router = router
        self.service = service
    }

    func setVC(vc: ProfileViewControllerProtocol) {
        self.vc = vc
    }

    func authenticate(username: String?, password: String?) {
        if let username = username, let password = password {
            if let _ = service?.authenticate(login: username, password: password) {
                if AppCoordinator.isFirstLaunch() {
                    skipAuthentication()
                } else {
                    update()
                }
            } else {
                vc?.showAuthError(description: "Auth error")
            }
        } else {
            vc?.showAuthError(description: "Incorrect input")
        }
    }

    func skipAuthentication() {
        AppCoordinator.setNotFirstLaunch()
        router.switchToMainFlow()
    }

    func update() {
        let user = service?.getUserData()
        if let user = user, let name = user.name, let familyName = user.familyName, let group =
        user.group {
            vc?.setUserName(str: name + " " + familyName)
            vc?.setUserGroup(str: group.name)
            vc?.setState(toView: .profile)
        } else {
            vc?.setState(toView: .auth)
        }
    }

    func logout() {
        service?.logout()
        update()
    }

    func navigateToProfileDetails() {
        router.navigateToProfileDetails()
    }

    func navigateToSettings() {
        router.navigateToSettings()
    }
}
