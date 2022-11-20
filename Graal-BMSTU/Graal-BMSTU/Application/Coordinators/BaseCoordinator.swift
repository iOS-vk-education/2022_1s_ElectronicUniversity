//
//  AppCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


class BaseCoordinator: CoordinatorProtocol
{
    private let window: UIWindow
    private let navigationController: UINavigationController
    private var coordinator: CoordinatorProtocol?
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        setupWindow()
    }
    
    func setupWindow() {
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "NotFirstLaunch") == nil
        {
            defaults.set(true, forKey: "NotFirstLaunch")
            coordinator = AuthCoordinator(window: window)
        }
        else
        {
            coordinator = MainFlowCoordinator(window: window)
        }
        coordinator?.start()
    }
    
    
}
