//
// Created by Артём on 06.12.2022.
//

import Foundation

// don't exist in DB

struct LessonsDay {
    var lessons: [Lesson]
    var date: Date
}

struct Schedule {
    let group: Group
    let today: LessonsDay
    let nextDay: LessonsDay
}
