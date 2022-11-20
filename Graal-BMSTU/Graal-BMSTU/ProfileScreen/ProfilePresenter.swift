//
//  ProfilePresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import UIKit


final class ProfilePresenterImpl: ProfilePresenter {

    weak var vc: ProfileViewController?
    private var service: ProfileService?
    private let coordinator: ProfileCoordinator

    init(coordinator: ProfileCoordinator, service: ProfileService) {
        self.coordinator = coordinator
        self.service = service
    }

    func authenticate(username: String?, password: String?) {
        if let username = username, let password = password {
            if let _ = service?.authenticate(login: username, password: password) {
                vc?.switchToProfile()
            } else {
                vc?.showAuthError(description: "Auth error")
            }
        } else {
            vc?.showAuthError(description: "Incorrect input")
        }
    }

    func update() {
        let user: User? = service?.getUserData()
        if let user = user {
            vc?.setState(to: .profile)
            vc?.setUserName(str: user.name + " " + user.familyName)
            vc?.setUserGroup(str: user.group)
        } else {
            vc?.setState(to: .auth)
        }
    }

    func logout() {
        service?.logout()
        update()
    }

    func navigateToProfileDetails()
    {
        coordinator.navigateToProfileDetails()
    }
}
