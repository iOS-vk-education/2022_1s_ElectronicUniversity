//
//  TabBarViewController.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//

import UIKit
import Rswift
import SFSafeSymbols

class TabBarViewController: UITabBarController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    func setupVCs()
    {
        let authPr = AuthViewPresenterImpl(authService: AuthService())
        viewControllers = [
            createNavController(for: AuthViewController(authViewPresenter: authPr), title: R.string.localizable.account_tab(), image: UIImage(systemSymbol: .personCircle)),
            createNavController(for: UIViewController(), title: "Test", image: UIImage(systemSymbol: .command))
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController
    {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = false
        rootViewController.navigationItem.title = title
        return navController
    }
}


// тут будет вьюконтроллер, который собирает в себя четыре экрана (главная, расписание...) и показывает внизу вкладки
