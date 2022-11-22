//
//  ProfileProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


protocol ProfilePresenter {
    init(coordinator: ProfileCoordinator, service: ProfileService)
    func update()

    // MARK: - связка с сервисом, функции для вьюшки
    func authenticate(username: String?, password: String?)
    func logout()
    func navigateToProfileDetails()
}

protocol ProfileCoordinator: Coordinator {
    func navigateToProfileDetails()
}

protocol ProfileViewController: AnyObject, UIViewController {
    func showAuthError(description: String?)
    func setUserName(str: String)
    func setUserGroup(str: String)
    func setState(to: ProfileViewState)
}

protocol ProfileService {
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
