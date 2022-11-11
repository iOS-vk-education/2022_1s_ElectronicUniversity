//
//  ProfileRouter.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


final class ProfileRouterImpl
{
    let window: UIWindow
    private(set) var viewController: UIViewController?
    
    init(window: UIWindow)
    {
        self.window = window
    }
    
    func setViewController(viewController: UIViewController)
    {
        self.viewController = viewController
    }
}

extension ProfileRouterImpl: ProfileRouter
{
    func continueWithAccount()
    {
        // пользователь при старте вошел в аккаунт
        BaseCoordinator(window: self.window).startMainScenario()
    }
    
    func continueWithoutAccount()
    {
        // пользователь при старте отказался входить в аккаунт
        BaseCoordinator(window: self.window).startMainScenario()
        
    }
    
    func switchToLogged()
    {
        // пользователь уже внутри приложения успешно вошел в аккаунт
    }
    
    func switchToUnlogged()
    {
        // пользователь вышел из аккаунта
    }
    
}
