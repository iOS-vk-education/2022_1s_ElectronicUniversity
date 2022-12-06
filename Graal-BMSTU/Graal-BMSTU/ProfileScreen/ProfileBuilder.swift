//
//  ProfileBuilder.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

final class ProfileBuilderImpl: ProfileBuilder {
    let presenter: ProfilePresenter
    let viewController: ProfileViewControllerProtocol
    let router: ProfileRouter

    private init(viewController: ProfileViewControllerProtocol, presenter: ProfilePresenter,
                 router: ProfileRouter) {
        self.viewController = viewController
        self.presenter = presenter
        self.router = router
    }

    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> ProfileBuilder {
        let router = ProfileRouterImpl(window: window, navigationController: navigationController)
        let presenter = ProfilePresenterImpl(router: router, service: AuthServiceMockup())
        let viewController = ProfileViewController(presenter: presenter)

        presenter.setVC(vc: viewController)
        router.setVC(vc: viewController)
        router.setMainFlowCoordinator(coordinator: MainFlowCoordinator(window: window,
                navigationController: navigationController))

        return ProfileBuilderImpl(viewController: viewController, presenter: presenter,
                router: router)
    }
}
