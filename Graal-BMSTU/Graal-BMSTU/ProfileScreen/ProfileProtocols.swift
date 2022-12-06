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
    func switchToMainFlow()
    func navigateToProfileDetails()
    func navigateToSettings()
    func setVC(vc: UIViewController)
    func setMainFlowCoordinator(coordinator: Coordinator)
}

protocol ProfileViewControllerProtocol: AnyObject {
    func showAuthError(description: String?)
    func setUserName(str: String)
    func setUserGroup(str: String)
    func setState(toView: ProfileViewState)
}

protocol ProfileBuilder {
    var presenter: ProfilePresenter { get }
    var viewController: ProfileViewControllerProtocol { get }
    var router: ProfileRouter { get }
    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> ProfileBuilder
}
