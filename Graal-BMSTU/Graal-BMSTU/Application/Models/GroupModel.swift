//
// Created by Артём on 06.12.2022.
//

import Foundation

enum StudyLevel: String, Comparable {
    static func <(lhs: StudyLevel, rhs: StudyLevel) -> Bool {
        return lhs.intDesc() < rhs.intDesc()
    }

    case BACHELOR, MASTER, SPECIALIST, POSTGRADUATE

    func intDesc() -> Int {
        switch self {
            case .BACHELOR:
                return 1
            case .MASTER:
                return 3
            case .SPECIALIST:
                return 2
            case .POSTGRADUATE:
                return 4
        }
    }
}

typealias StudyStreamID = Int
struct StudyStream: Hashable, Comparable {
    static func <(lhs: StudyStream, rhs: StudyStream) -> Bool {
        if lhs.faculty != rhs.faculty {
            return lhs.faculty < rhs.faculty
        } else if lhs.semester !=  rhs.semester {
            return lhs.semester < rhs.semester
        } else if lhs.studyLevel != rhs.studyLevel {
            return lhs.studyLevel < rhs.studyLevel
        } else {
            return true
        }
    }

    let dbPrimaryKey: StudyStreamID
    let semester: Int
    let faculty: String
    let studyLevel: StudyLevel
    let semesterStart: Date
    let semesterEnd: Date
}

typealias GroupID = Int
struct Group: Codable {
    let dbPrimaryKey: GroupID
    let name: String
    let stream: StudyStreamID
}
