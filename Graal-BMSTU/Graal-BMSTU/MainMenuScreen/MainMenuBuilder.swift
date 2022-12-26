//
// Created by Артём on 06.12.2022.
//

import UIKit

final class MainMenuBuilderImpl: MainMenuBuilder {
    let presenter: MainMenuPresenter
    let viewController: MainMenuViewControllerProtocol
    let router: MainMenuRouter

    private init(viewController: MainMenuViewControllerProtocol, presenter: MainMenuPresenter,
                 router: MainMenuRouter) {
        self.viewController = viewController
        self.presenter = presenter
        self.router = router
    }

    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> MainMenuBuilder {
        let router = MainMenuRouterImpl(window: window, navigationController: navigationController)
        let presenter = MainMenuPresenterImpl(router: router, service: ScheduleServiceImpl())
        let viewController = MainMenuViewController(presenter: presenter)

        presenter.setVC(vc: viewController)
        router.setVC(vc: viewController)

        return MainMenuBuilderImpl(viewController: viewController, presenter: presenter,
                router: router)
    }
}
