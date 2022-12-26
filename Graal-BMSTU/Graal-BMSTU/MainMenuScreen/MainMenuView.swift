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

typealias NextDayAction = () -> Void
typealias PreviousDayAction = () -> Void

final class MainMenuView: UIView {
    private var weekLabel = UILabel(frame: .zero)
    private var dateLabel = UILabel(frame: .zero)
    private var nextDayButton = UIButton(frame: .zero)
    private var previousDayButton = UIButton(frame: .zero)
    private var scheduleTable = UITableView(frame: .zero)

    private var nextDayAction: NextDayAction?
    private var previousDayAction: PreviousDayAction?

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

    func reload() {
        scheduleTable.reloadData()
    }

    func setWeekSeqNum(seqNum: Int) {

    }

    func setDate(date: Date) {

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
        weekLabel.text = "Неделя 16, знаменатель" // placeholder
        weekLabel.numberOfLines = 1
    }

    func scheduleTableConf() {
        scheduleTable.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
    }
}

private extension MainMenuView {
    @objc func nextDayButtonTapped() {

    }

    @objc func previousDayButtonTapped() {

    }
}