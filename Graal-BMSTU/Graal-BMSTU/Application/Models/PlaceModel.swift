//
// Created by Артём on 06.12.2022.
//

import Foundation

enum BMSTUBuilding {
    case GZ, ULK, LT, E, SM, MT, MF, FV
    // не добавить ли сюда ФВ?
    var textDesc: String {
        switch (self) {
        case .GZ:
            return R.string.localizable.gz_building_name()
        case .ULK:
            return R.string.localizable.ulk_building_name()
        case .LT:
            return R.string.localizable.lt_building_name()
        case .E:
            return R.string.localizable.e_building_name()
        case .SM:
            return R.string.localizable.sm_building_name()
        case .MT:
            return R.string.localizable.mt_building_name()
        case .MF:
            return R.string.localizable.mf_building_name()
        case .FV:
            return R.string.localizable.fv_building_name()
        }
    }
}

struct Place {
    var name: String
    var building: BMSTUBuilding
}

// places
let gz_pl_1 = Place(name: "308ю", building: .GZ)
let gz_pl_2 = Place(name: "327", building: .GZ)
let ulk_pl_1 = Place(name: "218л", building: .ULK)
let ulk_pl_2 = Place(name: "533л", building: .ULK)
let e_pl_1 = Place(name: "332э", building: .E)
let e_pl_2 = Place(name: "каф.", building: .E)
