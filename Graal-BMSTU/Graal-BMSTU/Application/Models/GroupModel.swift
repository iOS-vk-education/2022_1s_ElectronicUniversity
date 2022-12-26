//
// Created by Артём on 06.12.2022.
//

import Foundation

enum StudyLevel {
    case bachelor, master, specialist, postgraduate
}

typealias StudyStreamID = Int
struct StudyStream: Hashable {

    let dbPrimaryKey: StudyStreamID
    let semester: Int
    let faculty: String
    let studyLevel: StudyLevel
    let semesterStart: Date
    let semesterEnd: Date
}

typealias GroupID = Int
struct Group {

    let dbPrimaryKey: GroupID
    let name: String
    let stream: StudyStream
}
