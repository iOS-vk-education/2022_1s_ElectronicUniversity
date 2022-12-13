//
// Created by Артём on 06.12.2022.
//

import UIKit

protocol MainMenuPresenter {
    init(router: MainMenuRouter, service: ScheduleService)
    func update()
    func setVC(vc: MainMenuViewControllerProtocol)

    // MARK: - связка с сервисом, функции для вьюшки
    func navigateToFullSchedule(position: SchedulePosition)
    func navigateToGroupSelection()
}

protocol MainMenuRouter: Router {
    func navigateToFullSchedule(group: Group, position: SchedulePosition)
    func navigateToGroupSelection()
}

protocol MainMenuViewControllerProtocol: AnyObject, UITableViewDataSource, UITableViewDelegate {

}


protocol MainMenuBuilder {
    var presenter: MainMenuPresenter { get }
    var viewController: MainMenuViewControllerProtocol { get }
    var router: MainMenuRouter { get }
    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> MainMenuBuilder
}
