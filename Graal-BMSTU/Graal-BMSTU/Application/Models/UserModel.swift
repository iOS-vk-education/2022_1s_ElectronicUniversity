//
//  ProfileModel.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

struct User: Codable {
    var name: String?
    var familyName: String?
    var group: Group?
}
