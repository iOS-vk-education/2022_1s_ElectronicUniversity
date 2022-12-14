//
// Created by Артём on 06.12.2022.
//

import Foundation

struct LessonsDay {
    var lessons: [Lesson]
    var date: Date
}

let less_day_today = LessonsDay(lessons: lessons_today,
        date: Date(timeIntervalSince1970: 1670965200))

let less_day_next_day = LessonsDay(lessons: lessons_today,
        date: Date(timeIntervalSince1970: 1670966200))