//
// Created by Артём on 06.12.2022.
//

import UIKit

enum SchedulePosition: Int {
    case today = 0, nextDay
}

final class MainMenuViewController: UIViewController {
    private let presenter: MainMenuPresenter
    private var mainMenuView = MainMenuView(frame: .zero)

    init(presenter: MainMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)

        navigationConf()
        setupActions()
        view = mainMenuView

        self.presenter.setVC(vc: self)
        self.presenter.update()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK:
extension MainMenuViewController: MainMenuViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getLessonsCnt(day: SchedulePosition(rawValue: section))
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lesson = presenter.getLesson(day: SchedulePosition(rawValue: indexPath.section),
                indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as! LessonCell
        cell.lesson = lesson
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension MainMenuViewController {
    func setupActions() {
        mainMenuView.setSeeFullScheduleAction(self.presenter.navigateToFullSchedule)
        mainMenuView.setSelectGroupAction(self.presenter.navigateToGroupSelection)
    }

    func navigationConf() {
        navigationItem.title = "Schedule"
    }
}


