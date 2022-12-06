//
// Created by Артём on 06.12.2022.
//

import Foundation

enum BMSTUBuilding {
    case GZ, ULK, LT, E, SM, MT, MF

    var textDesc: String {
        switch (self) {
        case .GZ:
            R.string.localizable.gz_building_name()
        case .ULK:
            R.string.localizable.ulk_building_name()
        case .LT:
            R.string.localizable.lt_building_name()
        case .E:
            R.string.localizable.e_building_name()
        case .SM:
            R.string.localizable.sm_building_name()
        case .MT:
            R.string.localizable.mt_building_name()
        case .MF:
            R.string.localizable.mf_building_name()
        }
    }
}

struct Place {
    var name: String
    var building: BMSTUBuilding
}