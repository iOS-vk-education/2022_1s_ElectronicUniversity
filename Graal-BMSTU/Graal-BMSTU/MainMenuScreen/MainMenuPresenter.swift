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

    init(router: MainMenuRouter, dataService: ScheduleService, authService: AuthService) {
        self.router = router
        self.dataService = dataService
        self.authService = authService
    }

    func setVC(vc: MainMenuViewControllerProtocol) {
        self.vc = vc
    }

    func update() {
        vc?.reload()
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

    func getSelectedGroup() -> Group? {
        return authService.getUserData()?.group
    }

    func getToNextDay() {
        self.previousDayOffset = currentDayOffset
        self.currentDayOffset += 1
        vc?.reload()
    }

    func getToPreviousDay() {
        self.previousDayOffset = currentDayOffset
        self.currentDayOffset -= 1
        vc?.reload()
    }

    func getTransitionDirection() -> Int {
        return self.currentDayOffset - self.previousDayOffset
    }
}