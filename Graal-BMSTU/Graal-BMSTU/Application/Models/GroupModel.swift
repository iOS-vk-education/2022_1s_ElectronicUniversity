//
// Created by Артём on 06.12.2022.
//

import Foundation

enum StudyLevel {
    case bachelor, master, specialist, postgraduate
}

struct StudyStream {
    var dbPrimaryKey: Int
    var semester: Int
    var faculty: String
    var studyLevel: StudyLevel
    var semesterStart: Date
    var semesterEnd: Date
}

struct Group {
    var dbPrimaryKey: Int
    var name: String
    var stream: StudyStream
}
