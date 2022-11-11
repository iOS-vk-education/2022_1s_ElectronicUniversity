//
//  AppCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


class BaseCoordinator: AppCoordinatorProtocol
{
    private let window: UIWindow
    private var authFlow: CoordinatorProtocol?
    private var mainFlow: CoordinatorProtocol?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func startAuthScenario() {
        authFlow = AuthCoordinator(window: window)
        authFlow?.start()
    }
    
    func startMainScenario() {
        mainFlow = MainFlowCoordinator(window: window)
        mainFlow?.start()
    }
}
