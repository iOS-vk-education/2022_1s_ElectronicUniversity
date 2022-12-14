//
// Created by Артём on 06.12.2022.
//

import Foundation

struct Lesson {
    var subject: Subject
    var place: Place
    var teacher: Teacher
    var startTime: Date
    var endTime: Date
}

let less_1 = Lesson(subject: discret, place: ulk_pl_1, teacher: discret_tch_2,
        startTime: today_first_session,
        endTime: today_first_session.addingTimeInterval(session_len))
// окно
let less_3 = Lesson(subject: pravo, place: gz_pl_2, teacher: pravo_tch_2,
        startTime: today_first_session.addingTimeInterval(
                2 * session_len + 2 * between_session_len),
        endTime: today_first_session.addingTimeInterval(3 * session_len + 2 * between_session_len))
let less_4 = Lesson(subject: pravo, place: gz_pl_1, teacher: pravo_tch_1,
        startTime: today_first_session.addingTimeInterval(
                3 * session_len + 3 * between_session_len),
        endTime: today_first_session.addingTimeInterval(4 * session_len + 3 * between_session_len))
let less_5 = Lesson(subject: tisd, place: ulk_pl_2, teacher: tisd_tch_1,
        startTime: today_first_session.addingTimeInterval(
                4 * session_len + 4 * between_session_len),
        endTime: today_first_session.addingTimeInterval(5 * session_len + 4 * between_session_len))

let lessons_today = [less_1, less_3, less_4, less_5]