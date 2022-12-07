//
//  MainCoordinator.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit
import RswiftResources
import SFSafeSymbols


final class MainFlowCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    private let window: UIWindow
    private var childCoordinators: [Coordinator] = []
    private var navigationController: UINavigationController

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
    }
}

// MARK: - appearance
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
        guard let navController = navigationControllers[.mainMenu] else {
            return
        }
        let built = MainMenuBuilderImpl.assemble(window: window,
                navigationController: navController)
        built.router.start()
    }

    func setupScheduleTab() {
        guard let navController = navigationControllers[.schedule] else {
            return
        }
//        let built = ScheduleBuilder.assemble()
        let built = UIViewController()
        built.view.backgroundColor = .white
        navController.setViewControllers([built], animated: false)
    }

    func setupTrainingTab() {
        guard let navController = navigationControllers[.training] else {
            return
        }
//        let built = TrainingBuilder.assemble()
        let built = UIViewController()
        built.view.backgroundColor = .white
        navController.setViewControllers([built], animated: false)
    }

    func setupProfileTab() {
        guard let navController = navigationControllers[.profile] else {
            return
        }
        let built = ProfileBuilderImpl.assemble(window: window, navigationController: navController)
        built.router.start()
    }
}

private extension MainFlowCoordinator {
    static func makeNavigationControllers() -> [TabType: UINavigationController] {
        var result: [TabType: UINavigationController] = [:]

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
