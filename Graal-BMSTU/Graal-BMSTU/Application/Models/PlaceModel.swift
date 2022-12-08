//
// Created by Артём on 06.12.2022.
//

import Foundation

enum BMSTUBuilding {
    case GZ, ULK, LT, E, SM, MT, MF

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
        }
    }
}

struct Place {
    var name: String
    var building: BMSTUBuilding
}