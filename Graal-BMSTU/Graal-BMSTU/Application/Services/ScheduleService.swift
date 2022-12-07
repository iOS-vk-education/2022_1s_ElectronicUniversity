//
// Created by Артём on 06.12.2022.
//

import Foundation

protocol ScheduleService {
    func getSelectedGroupSchedule() -> Schedule
}

final class ScheduleServiceMockup: ScheduleService {
    func getSelectedGroupSchedule() -> Schedule {
        return Schedule(group: Group(name: "ИУ7-35Б"),
                today: LessonsDay(lessons: [], date: Date.now),
                nextDay: LessonsDay(lessons: [], date: Date.now.addingTimeInterval(172800)))
    }
}