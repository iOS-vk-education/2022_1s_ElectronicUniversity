//
// Created by Артём on 06.12.2022.
//

import UIKit

protocol MainMenuPresenter {
    init(router: MainMenuRouter, dataService: ScheduleService, authService: AuthService)
    func update()
    func setVC(vc: MainMenuViewControllerProtocol)

    // MARK: - связка с роутером
    func navigateToGroupSelection()
    func navigateToLessonDetails(seqNum: Int)

    // MARK: - работа с данными
    func getLessonsCnt() -> Int // константа, т.к. пустые тоже показываем
    func getLesson(seqNum: Int) -> Lesson?
    func getSelectedGroup() -> Group?

    // MARK: - работа с состоянием
    func getToNextDay()
    func getToPreviousDay()
    // +1 = new day is "tomorrow" for previously selected
    // -1 = new day is "yesterday" for previously selected
    // 0 = first selection
    func getTransitionDirection() -> Int
    func getDayInfo() -> (Int, Date) // weekSeqNum, selectedDay

}

protocol MainMenuRouter: Router {
    func navigateToLessonDetails(lesson: Lesson)
    func navigateToGroupSelection()
}

protocol MainMenuViewControllerProtocol: AnyObject, UITableViewDataSource, UITableViewDelegate {
    func reload()
}


protocol MainMenuBuilder {
    var presenter: MainMenuPresenter { get }
    var viewController: MainMenuViewControllerProtocol { get }
    var router: MainMenuRouter { get }
    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> MainMenuBuilder
}
