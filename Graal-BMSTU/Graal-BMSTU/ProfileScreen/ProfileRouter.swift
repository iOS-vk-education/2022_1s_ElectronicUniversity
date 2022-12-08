//
//  ProfileRouter.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

final class ProfileRouterImpl: ProfileRouter {


    private let window: UIWindow
    var parentCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    private weak var viewController: UIViewController?
    private var flowAfterFirstAuth: Coordinator?

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    convenience init(window: UIWindow, navigationController: UINavigationController,
                     flowAfterFirstAuth: Coordinator) {
        self.init(window: window, navigationController: navigationController)
        self.flowAfterFirstAuth = flowAfterFirstAuth
    }

    func setVC(vc: UIViewController) {
        self.viewController = vc
    }

    func start() {
        if let viewController = viewController {
            navigationController.pushViewController(viewController, animated: true)
        }
        self.window.makeKeyAndVisible()
    }

    // MARK: - flow changer

    func switchToMainFlow() {
        print("change flow")
        flowAfterFirstAuth?.start()
    }

    // MARK: - navigation actions
    func navigateToProfileDetails() {
        print("navigate")
        let placeholder = UIViewController()
        placeholder.view.backgroundColor = .darkGray
        let placeholderLabel = UILabel()
        placeholderLabel.text = R.string.localizable.your_profile_button_title()
        placeholder.view.addSubview(placeholderLabel)
        navigationController.pushViewController(placeholder, animated: true)
        //        let child = DetailProfileBuilder.assemble(window: window, navigationController: navigationController)
        //        childCoordinators.append(child.coordinator)
        //        child.coordinator.parentCoordinator = self
        //        child.coordinator.start()
    }

    func navigateToSettings() {
        print("navigate")
        let placeholder = UIViewController()
        placeholder.view.backgroundColor = .gray
        let placeholderLabel = UILabel()
        placeholderLabel.text = R.string.localizable.settings_button_title()
        placeholder.view.addSubview(placeholderLabel)
        navigationController.pushViewController(placeholder, animated: true)
        //        let child = SettingsBuilder.assemble(window: window, navigationController: navigationController)
        //        childCoordinators.append(child.coordinator)
        //        child.coordinator.parentCoordinator = self
        //        child.coordinator.start()
    }
}
