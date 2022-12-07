//
//  ProfileProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

protocol ProfilePresenter {
    init(router: ProfileRouter, service: AuthService)
    func update()
    func setVC(vc: ProfileViewControllerProtocol)

    // MARK: - связка с сервисом, функции для вьюшки
    func authenticate(username: String?, password: String?)
    func skipAuthentication()
    func logout()
    func navigateToProfileDetails()
    func navigateToSettings()
}

protocol ProfileRouter: Coordinator {
    init(window: UIWindow, navigationController: UINavigationController,
         flowAfterFirstAuth: Coordinator)
    func start()
    func switchToMainFlow()
    func navigateToProfileDetails()
    func navigateToSettings()
    func setVC(vc: UIViewController)
}

protocol ProfileViewControllerProtocol: AnyObject {
    func showAuthError(description: String?)
    func setUserName(str: String)
    func setUserGroup(str: String)
    func setState(toView: ProfileViewState)
}

protocol AuthService {
    func authenticate(login: String, password: String) -> User?
    func getUserData() -> User?
    func logout()
}

protocol ProfileBuilder {
    var presenter: ProfilePresenter { get }
    var viewController: ProfileViewControllerProtocol { get }
    var router: ProfileRouter { get }
    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> ProfileBuilder
}
