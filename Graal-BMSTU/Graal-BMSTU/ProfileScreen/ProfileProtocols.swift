//
//  ProfileProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


protocol ProfilePresenter {
    init(coordinator: ProfileCoordinator, service: AuthService)
    func update()
    func setVC(vc: ProfileViewController)

    // MARK: - связка с сервисом, функции для вьюшки
    func authenticate(username: String?, password: String?)
    func skipAuthentication()
    func logout()
    func navigateToProfileDetails()
    func navigateToSettings()
}

protocol ProfileCoordinator: Coordinator {
    func navigateToProfileDetails()
    func navigateToSettings()
    func setVC(vc: UIViewController)
}

protocol ProfileViewController: AnyObject {
    func showAuthError(description: String?)
    func setUserName(str: String)
    func setUserGroup(str: String)
    func setState(to: ProfileViewState)
}

protocol AuthService {
    func authenticate(login: String, password: String) -> User?
    func getUserData() -> User?
    func logout()
}

protocol ProfileBuilder {
    var presenter: ProfilePresenter { get }
    var viewController: ProfileViewController { get }
    var coordinator: ProfileCoordinator { get }
    static func assemble(window: UIWindow, navigationController: UINavigationController) -> ProfileBuilder
}
