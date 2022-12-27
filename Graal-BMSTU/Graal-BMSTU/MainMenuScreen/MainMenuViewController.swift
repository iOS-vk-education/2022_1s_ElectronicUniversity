//
// Created by Артём on 06.12.2022.
//

import UIKit
import RswiftResources

enum SchedulePosition: Int {
    case today = 0, nextDay
}

final class MainMenuViewController: UIViewController {
    private let presenter: MainMenuPresenter
    private var mainMenuView = MainMenuView(frame: .zero)

    init(presenter: MainMenuPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        titleConf()
        setupActions()
        mainMenuView.setDataSource(dataSource: self)
        view = mainMenuView
        self.presenter.setVC(vc: self)
        self.presenter.update()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func reload() {
        titleConf()
        let (weekSeqNum, dayDate) = presenter.getDayInfo()
        mainMenuView.setWeekSeqNum(seqNum: weekSeqNum)
        mainMenuView.setDate(date: dayDate)
        mainMenuView.reload()
    }
}

// MARK: - table view data source

extension MainMenuViewController: MainMenuViewControllerProtocol {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getLessonsCnt()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let lesson = presenter.getLesson(seqNum: indexPath.row + 1)
        let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell") as! LessonCell
        cell.lesson = lesson // if nil, some placeholder is created
        return cell
    }

//    func tableView()

    // MARK: - animation

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        let direction = presenter.getTransitionDirection()
        switch (direction) {
            case -1:
                print("-1")
            case +1:
                print("1")
            case 0:
                print("0")
            default:
                return
        }
    }
}

private extension MainMenuViewController {
    func setupActions() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemSymbol: .gear),
                style: .plain, target: self, action: #selector(groupSelectButtonTapped))
        mainMenuView.setupNextDayAction(presenter.getToNextDay)
        mainMenuView.setupPreviousDayAction(presenter.getToPreviousDay)
    }

    func titleConf() {
        if let group = presenter.getSelectedGroup() {
            navigationItem.title = group.name
        } else {
            navigationItem.title = R.string.localizable.main_menu_title()
        }
    }
}

// MARK: -  actions

private extension MainMenuViewController {
    @objc func groupSelectButtonTapped() {
        let tmp = UIViewController()
        tmp.view.backgroundColor = .systemYellow
        //         NotificationCenter.default.post(name: NSNotification.Name("selectedgroup.changeoccurred"), object: nil)        NotificationCenter.default.post(name: NSNotification.Name("selectedgroup.changeoccurred"), object: nil)
        self.navigationController?.pushViewController(tmp, animated: true)
    }
}


