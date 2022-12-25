//
//  AuthFlowCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

final class AuthFlowCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    private var navigationController: UINavigationController
    private let window: UIWindow

    required init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func start() {
        let child = ProfileBuilderImpl.assemble(window: window, navigationController: navigationController)
        child.router.start()
    }
}
