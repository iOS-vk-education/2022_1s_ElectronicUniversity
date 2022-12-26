//
//  MainMenuPresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

final class MainMenuPresenterImpl: MainMenuPresenter {
    private weak var vc: MainMenuViewControllerProtocol?
    private var dataService: ScheduleService
    private var authService: AuthService
    private let router: MainMenuRouter
    private var currentDayOffset: Int = 0
    private var previousDayOffset: Int = 0
    private var daysLessons: [Lesson]?
    private var nowDate: Date = Date.now

    init(router: MainMenuRouter, dataService: ScheduleService, authService: AuthService) {
        self.router = router
        self.dataService = dataService
        self.authService = authService
        self.update()
    }

    func setVC(vc: MainMenuViewControllerProtocol) {
        self.vc = vc
    }

    func update() {
        Task {
            await updateData()
            DispatchQueue.main.async { [self] in
                vc?.reload()
            }
        }
    }

    func navigateToGroupSelection() {
        router.navigateToGroupSelection()
    }
}

extension MainMenuPresenterImpl {
    func navigateToLessonDetails(seqNum: Int) {
        if let lesson = daysLessons?[seqNum] {
            router.navigateToLessonDetails(lesson: lesson)
        } else {
            print("No such lesson!")
        }
    }

    func getLessonsCnt() -> Int {
        return 7
    }

    func getLesson(seqNum: Int) -> Lesson? {
        return daysLessons?.first(where: { $0.pairSeqNum == seqNum })
    }

    func getDayInfo() -> (Int, Date) {
        return (18, nowDate.addingTimeInterval(TimeInterval(currentDayOffset * 24 * 60 * 60))) //
        // TODO
    }

    func getSelectedGroup() -> Group? {
        return authService.getUserData()?.group
    }

    func getToNextDay() {
        self.previousDayOffset = currentDayOffset
        self.currentDayOffset += 1
        self.update()
    }

    func getToPreviousDay() {
        self.previousDayOffset = currentDayOffset
        self.currentDayOffset -= 1
        self.update()
    }

    func getTransitionDirection() -> Int {
        return self.currentDayOffset - self.previousDayOffset
    }
}

private extension MainMenuPresenterImpl {
    func updateData() async {
        if let group = authService.getUserData()?.group {
            let tmp = await dataService.getGroupSchedule(group: group, forDay: self.currentDayOffset)
            self.daysLessons = tmp?.lessons
        } else {
            self.daysLessons = nil
        }
    }
}