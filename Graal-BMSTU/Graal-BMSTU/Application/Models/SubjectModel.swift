//
// Created by Артём on 06.12.2022.
//

import Foundation

typealias SubjectID = Int
struct Subject {

    let dbPrimaryKey: SubjectID
    let name: String
    let stream_id: Int
}
