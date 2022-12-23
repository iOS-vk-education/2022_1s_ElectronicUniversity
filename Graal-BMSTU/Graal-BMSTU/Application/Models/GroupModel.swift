//
// Created by Артём on 06.12.2022.
//
s
import Foundation

struct StudyStream {
    var semester: Int
    var specialty: String
    var faculty: String
}

let mock_stream = StudyStream(semester: 3, specialty: "09.03.04", faculty: "ИУ7")


struct Group {
    var name: String
    var stream: StudyStream
}

let mock_group = Group(name: "ИУ7-35Б", stream: mock_stream)



