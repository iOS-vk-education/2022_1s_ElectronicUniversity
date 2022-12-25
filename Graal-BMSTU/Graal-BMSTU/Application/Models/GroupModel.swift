//
// Created by Артём on 06.12.2022.
//

import Foundation

enum StudyLevel {
    case bachelor, master, specialist, postgraduate
}

struct StudyStream: Hashable {
    let dbPrimaryKey: Int
    let semester: Int
    let faculty: String
    let studyLevel: StudyLevel
    let semesterStart: Date
    let semesterEnd: Date
}

struct Group {
    let dbPrimaryKey: Int
    let name: String
    let stream: StudyStream
}
