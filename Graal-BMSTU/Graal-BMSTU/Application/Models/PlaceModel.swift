//
// Created by Артём on 06.12.2022.
//

import Foundation

typealias PlaceID = Int
struct Place {

    let dbPrimaryKey: PlaceID
    let name: String
    let is_generic: Bool
}
