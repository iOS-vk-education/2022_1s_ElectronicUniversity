//
// Created by Артём on 06.12.2022.
//

import Foundation
import SwiftyJSON

protocol ScheduleService {
    func getGroupSchedule(group: Group, forDay: Int) -> LessonsDay?
    func getGroupsList() -> [StudyStream: [Group]]
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
        guard let url else {
            return nil
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, let json = try? JSON(data: data) else {
                return nil
            }
            var result: [Lesson?] = [] // compactMap after
            for (index, subJSON): (String, JSON) in json { // iterate over list of lessons
                result.append(decodeLesson(json: subJSON))
            }
        }
        task.resume()
    }

    func getGroupsList() -> [StudyStream: [Group]] {

    }

    private func decodeLesson(json: JSON) -> Lesson? {
        // MARK:- id
        guard let id = json["teacher"].int else { return nil }

        // MARK:- teacher
        var teacher: Teacher?
        if json["teacher"] != JSON.null {
            let subJson = json["teacher"]
            if let id = subJson["id"].int, let name = subJson["display_name"].string {
                teacher = Teacher(dbPrimaryKey: id, displayName: name)
            }
        }

        // MARK:- place
        guard json["place"] != JSON.null else {
            return nil
        }
        let place_subJson = json["place"]
        guard let place_id = place_subJson["id"].int, let place_name = place_subJson["name"].string,
              let place_is_generic = place_subJson["is_generic"].bool else {
            return nil
        }
        let place = Place(dbPrimaryKey: place_id, name: place_name, is_generic: place_is_generic)

        // MARK:- subject
        guard json["subject"] != JSON.null else {
            return nil
        }
        let subject_subJson = json["subject"]
        guard let subject_id = subject_subJson["id"].int,
              let subject_name = subject_subJson["name"].string,
              let subject_stream = subject_subJson["stream_id"].int else {
            return nil
        }
        let subject = Subject(dbPrimaryKey: subject_id, name: subject_name,
                stream_id: subject_stream)

        // MARK:- startTime
        guard json["start_time"] != JSON.null, let start_time_str = json["start_time"].string else {
            return nil
        }
        let formatter = ISO8601DateFormatter()
        guard let start_time = formatter.date(from: start_time_str) else {
            return nil
        }

        // MARK:- endTime
        guard json["end_time"] != JSON.null, let end_time_str = json["end_time"].string else {
            return nil
        }
        guard let end_time = formatter.date(from: end_time_str) else {
            return nil
        }

        // MARK:- pairSeqNum
        guard json["pair_num"] != JSON.null, let pair_seq_num = json["pair_num"].int else {
            return nil
        }

        // MARK:- lessonType
        guard json["lesson_type"] != JSON.null, let lesson_type_str = json["lesson_type"].string
        else {
            return nil
        }
        guard let lesson_type = LessonType(rawValue: lesson_type_str) else {
            return nil
        }

        // MARK:- groups
        guard json["groups"] != JSON.null, let groups_subJson = json["groups"].array else {
            return nil
        }
        var groups:[GroupID] = []
        for elem in groups_subJson {
            if let id = elem.int {
                groups.append(id)
            } else {
                return nil
            }
        }

        var result = Lesson(dbPrimaryKey: id,
                subject: subject,
                place: place,
                teacher: teacher,
                startTime: start_time, endTime: end_time,
                pairSeqNum: pair_seq_num,
                lessonType: lesson_type, groups: groups)
        return result
    }
}

