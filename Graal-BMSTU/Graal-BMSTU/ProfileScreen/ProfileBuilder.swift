//
//  ProfileBuilder.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

final class ProfileBuilderImpl: ProfileBuilder {
    let presenter: ProfilePresenter
    let viewController: ProfileViewController
    let coordinator: ProfileCoordinator

    private init(viewController: ProfileViewController, presenter: ProfilePresenter, coordinator: ProfileCoordinator) {
        self.viewController = viewController
        self.presenter = presenter
        self.coordinator = coordinator
    }

    static func assemble(window: UIWindow, navigationController: UINavigationController) -> ProfileBuilder {
        let coordinator = ProfileCoordinatorImpl(window: window, navigationController: navigationController)
        let presenter = ProfilePresenterImpl(coordinator: coordinator, service: AuthServiceMockup())
        let viewController = ProfileViewControllerImpl(presenter: presenter, state: .auth)

        presenter.setVC(vc: viewController)
        coordinator.setVC(vc: viewController)

        return ProfileBuilderImpl(viewController: viewController, presenter: presenter, coordinator: coordinator)
    }
}
