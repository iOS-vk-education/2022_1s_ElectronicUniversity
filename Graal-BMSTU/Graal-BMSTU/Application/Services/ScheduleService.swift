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
        return Schedule(group: Group(name: "ИУ7-35Б"), today: LessonsDay(lessons: lessons_today,
                date: Date(timeIntervalSince1970: 1670965200)),
                nextDay: LessonsDay(lessons: lessons_today,
                        date: Date(timeIntervalSince1970: 1670966200)))
    }

    func getSelectedGroup() -> Group {
        return Group(name: "IU7-35B")
    }
}

// times
let today_first_session = Date(timeIntervalSince1970: 1670995800) // среда, 14 декабря 2022
let nextDay_first_session = Date(timeIntervalSince1970: 1671082200) // четверг, 15 декабря 2022
let session_len = TimeInterval(5700) // 1 час 35 минут = 1 пара
let between_session_len = TimeInterval(600) // 10 минут = 1 перемена

// DAYS
let lessons_today = [Lesson(subject: discret, place: ulk_pl_1, teacher: discret_tch_2,
        startTime: today_first_session,
        endTime: today_first_session.addingTimeInterval(session_len)), // окно
    Lesson(subject: pravo, place: gz_pl_2, teacher: pravo_tch_2,
            startTime: today_first_session.addingTimeInterval(
                    2 * session_len + 2 * between_session_len),
            endTime: today_first_session.addingTimeInterval(
                    3 * session_len + 2 * between_session_len)), Lesson(subject: pravo,
            place: gz_pl_1, teacher: pravo_tch_1, startTime: today_first_session.addingTimeInterval(
            3 * session_len + 3 * between_session_len),
            endTime: today_first_session.addingTimeInterval(
                    4 * session_len + 3 * between_session_len)), Lesson(subject: tisd,
            place: ulk_pl_2, teacher: tisd_tch_1, startTime: today_first_session.addingTimeInterval(
            4 * session_len + 4 * between_session_len),
            endTime: today_first_session.addingTimeInterval(
                    5 * session_len + 4 * between_session_len)), ]
