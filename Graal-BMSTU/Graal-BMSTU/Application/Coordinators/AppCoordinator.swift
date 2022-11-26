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
    private var childCoordinators = [Coordinator]()
    private var navigationController: UINavigationController
    
    static let firstLaunchKey = "NotFirstLaunch"

    required init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }

    func start() {
        if AppCoordinator.isFirstLaunch() {
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

    static func isFirstLaunch() -> Bool {
        return UserDefaults.standard.value(forKey: firstLaunchKey) == nil
    }
    
    static func setNotFirstLaunch() {
        UserDefaults.standard.set(true, forKey: firstLaunchKey)
    }
    
    static func resetFirstLaunch() {
        UserDefaults.standard.removeObject(forKey: firstLaunchKey)
    }

}
