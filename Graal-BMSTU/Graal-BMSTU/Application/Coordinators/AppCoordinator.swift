//
//  AppCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    private let window: UIWindow
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    required init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.window.rootViewController = self.navigationController
        self.window.makeKeyAndVisible()
    }

    func start() {
        if isFirstLaunch() {
            self.startAuth()
        } else {
            self.startMain()
        }
    }

    func startAuth() {
        let child = AuthFlowCoordinator(window: window, navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    func startMain() {
        let child = MainFlowCoordinator(window: window, navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.start()
    }

    private func isFirstLaunch() -> Bool {
        return UserDefaults.standard.value(forKey: "NotFirstLaunch") == nil
    }
}
