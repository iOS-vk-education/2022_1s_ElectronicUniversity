//
// Created by Артём on 06.12.2022.
//

import Foundation

enum LessonType {
    case LAB, SEM, LEC, PRACTICE, PHYSICAL, VUC
}

struct Lesson {
    let dbPrimaryKey: Int
    let subject: Subject
    let place: Place
    let teacher: Teacher?
    let startTime: Date
    let endTime: Date
    let pairSeqNum: Int
    let lessonType: LessonType
    let groups: [Group]
}
