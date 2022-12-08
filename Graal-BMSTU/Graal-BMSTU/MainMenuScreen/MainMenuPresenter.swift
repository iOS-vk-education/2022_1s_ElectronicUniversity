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
        if let schedule = service?.getSelectedGroupSchedule() {
            vc?.setGroupName(schedule.group.name)
            vc?.setTodayLessonsCnt(schedule.today.lessons.count)
            vc?.setTodayDate(schedule.today.date)
            vc?.setNextDayLessonsCnt(schedule.nextDay.lessons.count)
            vc?.setNextDayDate(schedule.nextDay.date)
            for (num, lesson) in schedule.today.lessons.enumerated() {
                vc?.setTodayLesson(seq_num: num, subjectName: lesson.subject.name,
                        lessonLocationName: lesson.place.name, teacherName: lesson.teacher.name,
                        startTime: lesson.startTime, endTime: lesson.endTime)
            }
            for (num, lesson) in schedule.nextDay.lessons.enumerated() {
                vc?.setNextDayLesson(seq_num: num, subjectName: lesson.subject.name,
                        lessonLocationName: lesson.place.name, teacherName: lesson.teacher.name,
                        startTime: lesson.startTime, endTime: lesson.endTime)
            }
        }
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