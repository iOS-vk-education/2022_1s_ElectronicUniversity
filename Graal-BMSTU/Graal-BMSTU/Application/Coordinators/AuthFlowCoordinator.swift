//
//  AuthFlowCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


final class AuthFlowCoordinator: Coordinator
{

    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator]
    private let window: UIWindow

    required init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start()
    {
        let child = ProfileBuilderImpl.assemble(window: window)
        childCoordinators.append(child.coordinator)
        child.coordinator.parentCoordinator = self
        child.coordinator.start()
    }
}
