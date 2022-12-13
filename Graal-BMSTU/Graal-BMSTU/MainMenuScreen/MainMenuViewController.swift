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
        mainMenuView.setDataSource(dataSource: self)
        view = mainMenuView

        self.presenter.setVC(vc: self)
        self.presenter.update()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

// MARK: - table view data source
extension MainMenuViewController: MainMenuViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let day = SchedulePosition(rawValue: section) else {
            return 0
        }
        return presenter.getLessonsCnt(day: day) // а может
        // оставлять пустые и писать в них только время?
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let day = SchedulePosition(rawValue: indexPath.section) else {
            return UITableViewCell()
        } //? нормально такое возвращать при ошибке?
        let lesson = presenter.getLesson(day: day, indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as! LessonCell
        cell.lesson = lesson
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

private extension MainMenuViewController {
    func setupActions() {
        //        mainMenuView.setSeeFullScheduleAction(self.presenter.navigateToFullSchedule)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemSymbol: .gear),
                style: .plain, target: self, action: #selector(groupSelectButtonTapped))
    }

    func navigationConf() {
        navigationItem.title = "Schedule"
    }

}

private extension MainMenuViewController {
    @objc func groupSelectButtonTapped() {
        self.presenter.navigateToGroupSelection()
    }
}


