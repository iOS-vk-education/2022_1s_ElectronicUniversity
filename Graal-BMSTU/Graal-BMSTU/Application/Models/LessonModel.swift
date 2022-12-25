//
// Created by Артём on 06.12.2022.
//

import Foundation

enum LessonType {
    case LAB, SEM, LEC, PRACTICE, PHYSICAL, VUC
}

struct Lesson {
    var dbPrimaryKey: Int
    var subject: Subject
    var place: Place
    var teacher: Teacher?
    var startTime: Date
    var endTime: Date
    var pairSeqNum: Int
    var lessonType: LessonType
    var groups: [Group]
}
