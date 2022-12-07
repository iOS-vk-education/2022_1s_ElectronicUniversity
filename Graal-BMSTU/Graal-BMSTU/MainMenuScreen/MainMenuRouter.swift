//
// Created by Артём on 06.12.2022.
//

import UIKit


final class MainMenuRouterImpl: MainMenuRouter {
    private let window: UIWindow
    var parentRouter: Router?
    var navigationController: UINavigationController
    private weak var viewController: UIViewController?

    init(window: UIWindow, navigationController: UINavigationController) {
        self.window = window
        self.navigationController = navigationController
    }

    func setVC(vc: UIViewController) {
        self.viewController = vc
    }

    func start() {
        if let vc = viewController {
            navigationController.pushViewController(vc, animated: true)
        }
        self.window.makeKeyAndVisible()
    }

    // MARK: - navigation
    func navigateToFullSchedule(group: Group) {
        print("navigate")
        let placeholder = UIViewController()
        placeholder.view.backgroundColor = .darkGray
        let placeholderLabel = UILabel()
        placeholderLabel.text = R.string.localizable.full_schedule_title()
        placeholder.view.addSubview(placeholderLabel)
        navigationController.pushViewController(placeholder, animated: true)
    }

    func navigateToGroupSelection() {
        print("navigate")
        let placeholder = UIViewController()
        placeholder.view.backgroundColor = .darkGray
        let placeholderLabel = UILabel()
        placeholderLabel.text = R.string.localizable.select_group_title()
        placeholder.view.addSubview(placeholderLabel)
        navigationController.pushViewController(placeholder, animated: true)
    }
}
