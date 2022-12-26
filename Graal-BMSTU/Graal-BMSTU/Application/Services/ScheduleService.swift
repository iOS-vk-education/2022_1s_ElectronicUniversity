//
// Created by Артём on 06.12.2022.
//

import Foundation
import SwiftyJSON

protocol ScheduleService {
    func getGroupSchedule(group: Group, forDay: Int) async -> LessonsDay?
    func getGroupsList() async -> [StudyStream: [Group]]?
    func getGroupInfo(groupID: GroupID) async -> (Group, StudyStream)?
}

final class ScheduleServiceImpl: ScheduleService {
    static let serverAddress = "http://127.0.0.1:8000"
    static let groupsURL = "/group/"
    static let lessonsURL = "/lessons/"
    static let pastLessonsURL = "/lessons/reverse_seq/"
    static let streamsURL = "/streams/"

    // получить расписание конкретной группы на конкретный день (день указывается с помощью
    // отступа от сегодня, 0 = сегодня, 1 = завтра, -1 = вчера
    func getGroupSchedule(group: Group, forDay: Int) async -> LessonsDay? {
        guard let url = decideURLforDay(group: group, forDay: forDay) else { return nil }
        var lessons: [Lesson] = []
        var data: Data?
        do {
            (data, _) = try await URLSession.shared.data(from: url)
        } catch is Error {
            return nil
        }
        guard let data, let json = try? JSON(data: data) else { return nil }
        var tmp: [Lesson?] = [] // compactMap after
        for (_, subJSON): (String, JSON) in json { // iterate over list of lessons
            tmp.append(self.decodeLesson(json: subJSON))
        }
        lessons = tmp.compactMap { $0 }
        guard let dayStart = getDayStart(forDay: forDay) else { return nil }
        let result = LessonsDay(lessons: lessons, date: dayStart)
        return result
    }

    // получить список всех групп на сервере, причем запиханных каждая в свой учебный поток

    func getGroupsList() async -> [StudyStream: [Group]]? {
        guard let allGroupsURL = getAllGroupsURL() else { return nil }
        guard let allStreamsURL = getAllStreamsURL() else { return nil }
        var streamsData: Data?
        var groupsData: Data?
        do {
            try await withThrowingTaskGroup(of: (URL, Data).self) { group in
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: allStreamsURL)
                    return (allStreamsURL, data)
                }
                group.addTask {
                    let (data, _) = try await URLSession.shared.data(from: allGroupsURL)
                    return (allGroupsURL, data)
                }
                for try await (url, data) in group {
                    if url == allStreamsURL {
                        streamsData = data
                    } else {
                        groupsData = data
                    }
                }
            }
        } catch is Error {
            return nil
        }
        guard let streamsData, let groupsData, let groupsJson = try? JSON(data: groupsData),
              let streamsJson = try? JSON(data: streamsData) else { return nil }
        guard let (groupsInStream, streams) = decodeStreams(json: streamsJson) else { return nil }
        guard let groups = decodeGroups(json: groupsJson) else { return nil }
        return composeGroupsList(streams: streams, groups: groups, groupsInStream: groupsInStream)
    }

    func getGroupInfo(groupID: GroupID) async -> (Group, StudyStream)? {
        return nil
    }
}

// MARK:- for getAllGroups

private extension ScheduleServiceImpl {
    // конструктор урл для страницы с данными всех групп
    func getAllGroupsURL() -> URL? {
        let str = "\(Self.serverAddress)\(Self.groupsURL)"
        return URL(string: str)
    }

    // конструктор урл для страницы с данными всех потоков

    func getAllStreamsURL() -> URL? {
        let str = "\(Self.serverAddress)\(Self.streamsURL)"
        return URL(string: str)
    }

    // процессит каждый учебный поток в массиве потоков, достает соответствие группы - поток

    func decodeStreams(json: JSON) -> ([StudyStreamID: [GroupID]], [StudyStream])? {
        var groupsInStream: [StudyStreamID: [GroupID]] = [:]
        var streams: [StudyStream] = []
        for (_, subJSON) in json {
            guard let (stream, groupsInside) = decodeStream(json: subJSON) else { return nil }
            groupsInStream[stream.dbPrimaryKey] = groupsInside
            streams.append(stream)
        }
        return (groupsInStream, streams)
    }

    // процессит все группы в массиве групп

    func decodeGroups(json: JSON) -> [Group]? {
        var groups: [Group] = []
        for (_, subJSON) in json {
            guard let group = decodeGroup(json: subJSON) else { return nil }
            groups.append(group)
        }
        return groups
    }

    // соединяет потоки и группы в словарь

    func composeGroupsList(streams: [StudyStream], groups: [Group],
                           groupsInStream: [StudyStreamID: [GroupID]]) -> [StudyStream: [Group]] {
        var ans: [StudyStream: [Group]] = [:]
        for stream in streams {
            var groupList: [Group] = []
            if let tmpGroupIDs = groupsInStream[stream.dbPrimaryKey] {
                groupList = groups.filter { groupElem in
                    return tmpGroupIDs.contains(groupElem.dbPrimaryKey)
                }
            }
            ans[stream] = groupList
        }
        return ans
    }
}

// MARK:- for decodeStreams

private extension ScheduleServiceImpl {
    // расшировывает конкретный учебный поток (поля)
    func decodeStream(json: JSON) -> (StudyStream, [GroupID])? {
        guard json["id"] != JSON.null, let id = json["id"].int else { return nil }
        guard json["semester"] != JSON.null, let semester = json["semester"].int else { return nil }
        guard json["faculty"] != JSON.null, let faculty = json["faculty"].string else { return nil }
        guard let studyLevel = decodeStudyLevel(json: json) else { return nil }
        guard let semesterStart = decodeSemesterStart(json: json) else { return nil }
        guard let semesterEnd = decodeSemesterEnd(json: json) else { return nil }
        guard let groups = decodeGroupsID(json: json) else { return nil }
        let stream = StudyStream(dbPrimaryKey: id, semester: semester, faculty: faculty,
                studyLevel: studyLevel, semesterStart: semesterStart, semesterEnd: semesterEnd)
        return (stream, groups)
    }

    func decodeStudyLevel(json: JSON) -> StudyLevel? {
        guard json["study_level"] != JSON.null,
              let str = json["study_level"].string else { return nil }
        return StudyLevel(rawValue: str)
    }

    func decodeSemesterStart(json: JSON) -> Date? {
        guard json["semester_start"] != JSON.null,
              let start_time_str = json["semester_start"].string else {
            return nil
        }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: start_time_str)
    }

    func decodeSemesterEnd(json: JSON) -> Date? {
        guard json["semester_end"] != JSON.null,
              let start_time_str = json["semester_end"].string else {
            return nil
        }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: start_time_str)
    }

    func decodeGroupsID(json: JSON) -> [GroupID]? {
        var ans: [GroupID] = []
        guard json["groups"] != JSON.null else { return nil }
        for (_, subJson) in json["groups"] {
            guard let id = subJson.int else { return nil }
            ans.append(id)
        }
        return ans
    }
}

// MARK:- for decodeGroups

private extension ScheduleServiceImpl {
    func decodeGroup(json: JSON) -> Group? {
        guard json["id"] != JSON.null, let id = json["id"].int else { return nil }
        guard json["name"] != JSON.null, let name = json["name"].string else { return nil }
        guard json["stream"] != JSON.null, let streamID = json["stream"].int else { return nil }
        return Group(dbPrimaryKey: id, name: name, stream: streamID)
    }
}

// MARK:- for getGroupSchedule

private extension ScheduleServiceImpl {
    // начало дня (0:00 утра)
    func getDayStart(forDay: Int) -> Date? {
        let date = Date.now
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        guard var newDate = Calendar.current.date(from: dateComponents) else {
            return nil
        }
        newDate.addTimeInterval(TimeInterval(forDay * 24 * 60 * 60))
        return newDate
    }

    // для просмотра предыдущих учебных дней используется другой урл, тк джанго не умеет в

    // отрицательные числа в урл
    func decideURLforDay(group: Group, forDay: Int) -> URL? {
        if forDay >= 0 {
            let str = "\(Self.serverAddress)\(Self.groupsURL)\(group.dbPrimaryKey)\(Self.lessonsURL)\(forDay)/"
            return URL(string: str)
        } else {
            let str = "\(Self.serverAddress)\(Self.groupsURL)\(group.dbPrimaryKey)\(Self.pastLessonsURL)\(forDay.magnitude)/"
            return URL(string: str)
        }
    }

    func decodeLesson(json: JSON) -> Lesson? {
        guard json["id"] != JSON.null, let id = json["id"].int else { return nil }
        let teacher: Teacher? = extractTeacher(json: json)
        guard let place = extractPlace(json: json) else { return nil }
        guard let subject = extractSubject(json: json) else { return nil }
        guard let startTime = extractStartTime(json: json) else { return nil }
        guard let endTime = extractEndTime(json: json) else { return nil }
        guard json["pair_num"] != JSON.null, let pairSeqNum = json["pair_num"].int else {
            return nil
        }
        guard let lessonType = extractLessonType(json: json) else { return nil }
        guard let groups = extractGroups(json: json) else { return nil }
        return Lesson(dbPrimaryKey: id, subject: subject, place: place, teacher: teacher,
                startTime: startTime, endTime: endTime, pairSeqNum: pairSeqNum,
                lessonType: lessonType, groups: groups)
    }

    // MARK:- extractors

    func extractTeacher(json: JSON) -> Teacher? {
        guard json["teacher"] != JSON.null else { return nil }
        let subJson = json["teacher"]
        if let id = subJson["id"].int, let name = subJson["display_name"].string {
            return Teacher(dbPrimaryKey: id, displayName: name)
        } else {
            return nil
        }
    }

    func extractPlace(json: JSON) -> Place? {
        guard json["place"] != JSON.null else { return nil }
        let place_subJson = json["place"]
        guard let place_id = place_subJson["id"].int, let place_name = place_subJson["name"].string,
              let place_is_generic = place_subJson["is_generic"].bool else { return nil }
        return Place(dbPrimaryKey: place_id, name: place_name, is_generic: place_is_generic)
    }

    func extractSubject(json: JSON) -> Subject? {
        guard json["subject"] != JSON.null else { return nil }
        let subject_subJson = json["subject"]
        guard let subject_id = subject_subJson["id"].int,
              let subject_name = subject_subJson["name"].string,
              let subject_stream = subject_subJson["stream_id"].int else { return nil }
        return Subject(dbPrimaryKey: subject_id, name: subject_name, stream_id: subject_stream)
    }

    func extractStartTime(json: JSON) -> Date? {
        guard json["start_time"] != JSON.null, let start_time_str = json["start_time"].string else {
            return nil
        }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: start_time_str)
    }

    func extractEndTime(json: JSON) -> Date? {
        guard json["end_time"] != JSON.null, let end_time_str = json["end_time"].string else {
            return nil
        }
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: end_time_str)
    }

    func extractLessonType(json: JSON) -> LessonType? {
        guard json["lesson_type"] != JSON.null,
              let lesson_type_str = json["lesson_type"].string else { return nil }
        return LessonType(rawValue: lesson_type_str)
    }

    func extractGroups(json: JSON) -> [GroupID]? {
        guard json["groups"] != JSON.null, let groups_subJson = json["groups"].array else {
            return nil
        }
        var groups: [GroupID] = []
        for elem in groups_subJson {
            if let id = elem.int {
                groups.append(id)
            } else {
                return nil
            }
        }
        return groups
    }
}

