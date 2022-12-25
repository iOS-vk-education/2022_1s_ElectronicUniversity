//
// Created by Артём on 06.12.2022.
//

import Foundation
import SwiftyJSON

protocol ScheduleService {
    func getSelectedGroupSchedule() -> Schedule
    func getSelectedGroup() -> Group
}

final class ScheduleServiceImpl: ScheduleService {
    static let serverAddress = "127.0.0.1:8000"
    static let groupsURL = "/group/"
    static let lessonsURL = "/lessons/"
    static let pastLessonsURL = "/lessons/reverse_seq/"

    func getGroupSchedule(group: Group, forDay: Int) -> LessonsDay? {
        var url: URL?
        if forDay >= 0 {
            let str = "\(Self.serverAddress)\(Self.groupsURL)\(group)\(Self.lessonsURL)\(forDay)/"
            url = URL(string: str)
        } else {
            let str = "\(Self.serverAddress)\(Self.groupsURL)\(group)\(Self.pastLessonsURL)\(forDay)/"
            url = URL(string: str)
        }
        guard let url else { return nil }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let json = try? JSON(data: data) {
                var result = LessonsDay(lessons: [], date: <#T##Date##Foundation.Date#>)
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }

    func getGroupsList() -> [StudyStream: [Group]] {

    }

    private func decodeLesson(json: JSON) -> Lesson {

    }
}

