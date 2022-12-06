//
// Created by Артём on 06.12.2022.
//

import UIKit

final class MainMenuViewController: UIViewController {
    private let presenter: MainMenuPresenter
    private var mainMenuView = MainMenuView(frame: .zero)
    init(presenter: MainMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        setupActions()
        self.presenter.setVC(vc: self)
        view = mainMenuView
        self.presenter.update()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - getting data from presenter
extension MainMenuViewController: MainMenuViewControllerProtocol {
    func setGroupName(_ name: String) {
        mainMenuView.setGroupName(name)
    }

    func setTodayLessonsCnt(_ cnt: Int) {
        mainMenuView.generateTodayLessonsTiles(cnt)
    }

    func setTodayDate(_ date: Date) {
        mainMenuView.setTodayDate(date.formatted(
                .dateTime.day(.defaultDigits) + " " + date.formatted(.dateTime.month(.wide))))
    }

    func setNextDayLessonsCnt(_ cnt: Int) {
        mainMenuView.generateNextDayLessonsTiles(cnt)
    }

    func setNextDayDate(_ date: Date) {
        mainMenuView.setNextDayDate(date.formatted(
                .dateTime.day(.defaultDigits) + " " + date.formatted(.dateTime.month(.wide))))
    }

    func setTodayLesson(seq_num: Int, subjectName: String, lessonLocationName: String,
                        teacherName: String, startTime: Date, endTime: Date) {
        mainMenuView.setTodayLesson(seq_num: seq_num, subjectName: subjectName,
                lessonLocationName: lessonLocationName, teacherName: teacherName,
                startTime: startTime.formatted(date: .omitted, time: .shortened),
                endTime: endTime.formatted(date: .omitted, time: .shortened))
    }

    func setNextDayLesson(seq_num: Int, subjectName: String, lessonLocationName: String,
                          teacherName: String, startTime: Date, endTime: Date) {
        mainMenuView.setNextDayLesson(seq_num: seq_num, subjectName: subjectName,
                lessonLocationName: lessonLocationName, teacherName: teacherName,
                startTime: startTime.formatted(date: .omitted, time: .shortened),
                endTime: endTime.formatted(date: .omitted, time: .shortened))
    }
}


