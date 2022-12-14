//
//  MainMenuView.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import UIKit
import SnapKit
import SFSafeSymbols
import RswiftResources


//let TableView = UIView.init(frame: CGRect.zero, style: .grouped)

//
//class TableViewController: UITableViewController {
//
//    private var data = ["Электроника", "Дискретная математика", "Физика", "Базы данных"]
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.view?.backgroundColor = UIColor.white
//        self.navigationItem.title = "Расписание"
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//
//        self.view.addSubview(self.tableView)
//        self.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableVieCell")
//        self.tableView.dataSource = self
//
//        self.updateLayout(with: self.view.frame.size)
//    }
//
//    override func viewWillTransition(to size: CGSize, with coordinator:
//                                     UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        coordinator.animate(alongsideTransition: { (contex) in
//            self.updateLayout(with: size)
//        }, completion: nil)
//    }
//
//    private func updateLayout(with size: CGSize) {
//        self.tableView.frame = CGRect.init(origin: .zero, size: size)
//    }
//}
//
//extension TableViewController: UITableViewDataSource {
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch tableView {
//        case self.tableView:
//            return self.data.count
//        default:
//            return 0
//        }
//    }
//
//    func tableView(tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
//                for: indexPath) as! TableViewCell
//        cell.textLabel?.text = self.data[indexPath.row]
//        if indexPath.row == 0 {
//            cell.accessoryType = .disclosureIndicator
//        }
//        return cell
//    }
//}
//
//class TableViewCell: UITableViewCell {
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        self.accessoryType = .none
//    }
//}

// -----------------------------------------------------

final class MainMenuView: UIView {
    private var weekLabel = UILabel(frame: .zero)
    private var scheduleTable = UITableView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }

    func setDataSource(dataSource: UITableViewDataSource) {
        self.scheduleTable.dataSource = dataSource
    }

}

private extension MainMenuView {
    func setupUI() {
        self.backgroundColor = .white
        weekLabelConf()
        scheduleTableConf()

        let elems = [weekLabel, scheduleTable]
        elems.forEach { box in
            self.addSubview(box)
        }
        setupConstraints()
    }

    func setupConstraints() {
        weekLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }

        scheduleTable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weekLabel.snp.bottom).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
        }
//        scheduleTable.rowHeight = 140
    }

    func weekLabelConf() {
        weekLabel.text = "Неделя 16/17" // placeholder
        weekLabel.numberOfLines = 1
    }

    func scheduleTableConf() {
        scheduleTable.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
    }
}
