//
//  MainCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit
import Rswift
import SFSafeSymbols


final class MainFlowCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    var navigationController: UINavigationController

    private let tabBarController = UITabBarController()
    private lazy var navigationControllers = MainFlowCoordinator.makeNavigationControllers()

    required init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }


    func start() {
        setupAllTabs()

        let navigationControllers = TabType.allCases.compactMap { // достаем вьюконтроллеры из словаря
            self.navigationControllers[$0]
        }
        tabBarController.setViewControllers(navigationControllers, animated: true)
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
//        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: {})
    }


}

private extension MainFlowCoordinator {
    func setupAppearance() {
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = .white
        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.shadowImage = nil
    }


    func setupAllTabs() {
        setupMainMenuTab()
        setupScheduleTab()
        setupTrainingTab()
        setupProfileTab()
    }


    func setupMainMenuTab() {
//        guard let navController = navigationControllers[.mainMenu] else {
//            fatalError("No navigation controller for main menu tab!")
//        }
//        let built = MainMenuBuilder.assemble()
//        navController.setViewControllers([built.vc], animated: false)
    }


    func setupScheduleTab() {
//        guard let navController = navigationControllers[.schedule] else {
//            fatalError("No navigation controller for schedule tab!")
//        }
//        let built = ScheduleBuilder.assemble()
//        navController.setViewControllers([built.vc], animated: false)
    }


    func setupTrainingTab() {
//        guard let navController = navigationControllers[.training] else {
//            fatalError("No navigation controller for training tab!")
//        }
//        let built = TrainingBuilder.assemble()
//        navController.setViewControllers([built.vc], animated: false)
    }


    func setupProfileTab() {
        guard let navController = navigationControllers[.profile] else {
            fatalError("No navigation controller for profile tab!")
        }
        let built = ProfileBuilderImpl.assemble(window: window, navigationController: navigationController)
        navController.setViewControllers([built.viewController], animated: false)
    }

}


fileprivate extension MainFlowCoordinator {
    static func makeNavigationControllers() -> [TabType: UINavigationController] {
        var result: [TabType: UINavigationController] = [:] // dictionary

        TabType.allCases.forEach { tab in
            let navController = UINavigationController()
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.unselectedImage, selectedImage: tab.image)
            navController.tabBarItem = tabBarItem
            result[tab] = navController
        }
        return result
    }
}


fileprivate enum TabType: Int, CaseIterable {
    case mainMenu, schedule, training, profile

    var title: String {
        switch self {
        case .mainMenu:
            return R.string.localizable.mainmenu_tabname()
        case .schedule:
            return R.string.localizable.schedule_tabname()
        case .training:
            return R.string.localizable.training_tabname()
        case .profile:
            return R.string.localizable.profile_tabname()
        }
    }

    var image: UIImage {
        switch self {
        case .mainMenu:
            return UIImage(systemSymbol: .houseFill)
        case .schedule:
            return UIImage(systemSymbol: .listClipboardFill)
        case .training:
            return UIImage(systemSymbol: .pencilLine)
        case .profile:
            return UIImage(systemSymbol: .personFill)
        }
    }

    var unselectedImage: UIImage {
        switch self {
        case .mainMenu:
            return UIImage(systemSymbol: .house)
        case .schedule:
            return UIImage(systemSymbol: .listClipboard)
        case .training:
            return UIImage(systemSymbol: .pencil)
        case .profile:
            return UIImage(systemSymbol: .person)
        }
    }
}
