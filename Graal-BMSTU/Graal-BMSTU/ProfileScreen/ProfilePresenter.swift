//
//  ProfilePresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

final class ProfilePresenterImpl: ProfilePresenter {

    private weak var vc: ProfileViewController?
    private var service: ProfileService?
    private let coordinator: ProfileCoordinator

    init(coordinator: ProfileCoordinator, service: ProfileService) {
        self.coordinator = coordinator
        self.service = service
    }
    
    func setVC(vc: ProfileViewController) {
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
        // coordinator.navigateToSettings()
    }
}
