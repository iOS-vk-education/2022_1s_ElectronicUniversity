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

protocol MainMenuViewControllerProtocol: AnyObject {
    func setGroupName(_ name: String)

    func setTodayLessonsCnt(_ cnt: Int)
    func setTodayDate(_ date: Date)
    func setNextDayLessonsCnt(_ cnt: Int)
    func setNextDayDate(_ date: Date)

    func setTodayLesson(seq_num: Int, subjectName: String, lessonLocationName: String,
                        teacherName: String, startTime: Date, endTime: Date)
    func setNextDayLesson(seq_num: Int, subjectName: String, lessonLocationName: String,
                          teacherName: String, startTime: Date, endTime: Date)
}


protocol MainMenuBuilder {
    var presenter: MainMenuPresenter { get }
    var viewController: MainMenuViewControllerProtocol { get }
    var router: MainMenuRouter { get }
    static func assemble(window: UIWindow,
                         navigationController: UINavigationController) -> MainMenuBuilder
}
