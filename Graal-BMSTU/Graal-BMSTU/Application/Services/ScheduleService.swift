//
// Created by Артём on 06.12.2022.
//

import Foundation

protocol ScheduleService {
    func getSelectedGroupSchedule() -> Schedule
    func getSelectedGroup() -> Group
}

final class ScheduleServiceMockup: ScheduleService {
    func getSelectedGroupSchedule() -> Schedule {
        return Schedule(group: Group(name: "ИУ7-35Б"),
                today: LessonsDay(lessons: [], date: Date.now),
                nextDay: LessonsDay(lessons: [], date: Date.now.addingTimeInterval(172800)))
    }
    func getSelectedGroup() -> Group {
        return Group(name: "IU7-35B")
    }
}