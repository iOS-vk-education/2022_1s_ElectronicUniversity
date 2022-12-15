//
// Created by Артём on 06.12.2022.
//

import Foundation
import FirebaseFirestoreSwift

protocol ScheduleService {
    func getSelectedGroupSchedule() -> Schedule
    func getSelectedGroup() -> Group
}

final class ScheduleServiceMockup: ScheduleService {
    func getSelectedGroupSchedule() -> Schedule {
        return Schedule(group: mock_group, today: less_day_today, nextDay: less_day_next_day)
    }

    func getSelectedGroup() -> Group {
        return mock_group
    }
}

// times
let today_first_session = Date(timeIntervalSince1970: 1670995800) // среда, 14 декабря 2022
let nextDay_first_session = Date(timeIntervalSince1970: 1671082200) // четверг, 15 декабря 2022
let session_len = TimeInterval(5700) // 1 час 35 минут = 1 пара
let between_session_len = TimeInterval(600) // 10 минут = 1 перемена


final class ScheduleServiceImpl: ScheduleService {
    func getSelectedGroupSchedule() -> Schedule {
        
    }

    func getSelectedGroup() -> Group {
        <#code#>
    }
 }

