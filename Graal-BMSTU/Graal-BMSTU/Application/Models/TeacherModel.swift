//
// Created by Артём on 06.12.2022.
//

import Foundation

struct Teacher {
    var name: String {
        familyName + " " + forename[forename.startIndex].uppercased() + ". " + fatherName[
                fatherName.startIndex].uppercased() + "."
    }
    var familyName: String // фамилия
    var forename: String // именно имя
    var fatherName: String // отчество
}

// teachers
let discret_tch_1 = Teacher(familyName: "Белоусов", forename: "Алексей", fatherName: "Иванович")
let discret_tch_2 = Teacher(familyName: "Андреева", forename: "Татьяна", fatherName: "Владимировна")
let pravo_tch_1 = Teacher(familyName: "Тиханова", forename: "Наталья", fatherName: "Евгеньевна")
let pravo_tch_2 = Teacher(familyName: "Буренина", forename: "Валентина", fatherName: "Игоревна")
let elect_tch_1 = Teacher(familyName: "Оглоблин", forename: "Дмитрий", fatherName: "Игоревич")
let tisd_tch_1 = Teacher(familyName: "Барышникова", forename: "Марина", fatherName: "Юрьевна")
let tisd_tch_2 = Teacher(familyName: "Силантьева", forename: "Александра", fatherName: "Васильевна")