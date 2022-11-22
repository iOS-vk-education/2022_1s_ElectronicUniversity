//
//  ProfileCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


final class ProfileCoordinatorImpl: ProfileCoordinator
{
    private let window: UIWindow
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    weak var viewController: ProfileViewController?

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }
    
    func start() {
        if let viewController = viewController {
            navigationController.pushViewController(viewController, animated: true)
        }
        self.window.makeKeyAndVisible()
    }

// MARK: - called from Presenter (точнее в презентере прокладка, так-то из вьюшки)
    func navigateToProfileDetails() {
        print("navigate")
//        let child = DetailProfileBuilder.assemble(window: window, navigationController: navigationController)
//        childCoordinators.append(child.coordinator)
//        child.coordinator.parentCoordinator = self
//        child.coordinator.start()
    }
}
