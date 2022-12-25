//
//  MainMenuPresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation


final class MainMenuPresenterImpl: MainMenuPresenter {
    private weak var vc: MainMenuViewControllerProtocol?
    private var service: ScheduleService?
    private let router: MainMenuRouter

    init(router: MainMenuRouter, service: ScheduleService) {
        self.router = router
        self.service = service
    }
    func setVC(vc: MainMenuViewControllerProtocol) {
        self.vc = vc
    }

    func update() {
        print("update main menu")
    }

    func navigateToFullSchedule(position: SchedulePosition) {
        if let group = service?.getSelectedGroup() {
            router.navigateToFullSchedule(group: group, position: position)
        }
    }

    func navigateToGroupSelection() {
        router.navigateToGroupSelection()
    }
}

extension MainMenuPresenterImpl {
    func getLessonsCnt(day: SchedulePosition) -> Int {
        guard let service = service else {
            return 0
        }
        switch (day) {
        case .today:
            return service.getSelectedGroupSchedule().today.lessons.count
        case .nextDay:
            return service.getSelectedGroupSchedule().nextDay.lessons.count
        }
    }

    func getLesson(day: SchedulePosition, _ num: Int) -> Lesson? {
        guard let service = service else {
            return nil
        }
        let schedule = service.getSelectedGroupSchedule()
        switch (day) {
        case .today:
            return schedule.today.lessons[num]
        case .nextDay:
            return schedule.nextDay.lessons[num]
        }
    }
}