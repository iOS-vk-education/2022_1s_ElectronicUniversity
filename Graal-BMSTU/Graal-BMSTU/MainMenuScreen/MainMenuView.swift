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
        let result = """
            \(R.string
               .localizable.week()) \(seqNum), \(seqNum % 2 == 1 ? R.string.localizable.numerator() : R.string.localizable.denominator())
            """
        self.weekLabel.text = result
    }

    func setDate(date: Date) {
        let result = date.formatted(.dateTime.day().month(.wide).weekday())
        self.dateLabel.text = result
    }

    func setupNextDayAction(_ action: @escaping NextDayAction) {
        self.nextDayAction = action
    }

    func setupPreviousDayAction(_ action: @escaping PreviousDayAction) {
        self.previousDayAction = action
    }
}

private extension MainMenuView {
    func setupUI() {
        self.backgroundColor = .white
        weekLabelConf()
        scheduleTableConf()
        nextDayButtonConf()
        previousDayButtonConf()
        let elems = [weekLabel, scheduleTable, nextDayButton, previousDayButton, dateLabel]
        elems.forEach { box in
            self.addSubview(box)
        }
        setupConstraints()
    }

    func setupConstraints() {
        weekLabel.snp.makeConstraints { make in
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(15)
            make.left.equalTo(safeAreaLayoutGuide.snp.centerX).offset(10)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        dateLabel.snp.makeConstraints { make in
            make.right.equalTo(safeAreaLayoutGuide.snp.centerX).inset(10)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(15)
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        previousDayButton.snp.makeConstraints { make in
            make.right.equalTo(safeAreaLayoutGuide.snp.centerX).inset(10)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(50)
        }
        nextDayButton.snp.makeConstraints { make in
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(10)
            make.left.equalTo(safeAreaLayoutGuide.snp.centerX).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(10)
            make.height.equalTo(50)
        }
        scheduleTable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weekLabel.snp.bottom).offset(10)
            make.left.equalTo(safeAreaLayoutGuide.snp.left)
            make.right.equalTo(safeAreaLayoutGuide.snp.right)
            make.bottom.equalTo(nextDayButton.snp.top).offset(-10)
        }
    }

    func weekLabelConf() {
        weekLabel.numberOfLines = 1
        weekLabel.textAlignment = .right
        // font?
    }

    func dateLabelConf() {
        dateLabel.numberOfLines = 1
        dateLabel.textAlignment = .left
        // font?
    }

    func scheduleTableConf() {
        scheduleTable.register(LessonCell.self, forCellReuseIdentifier: "LessonCell")
        scheduleTable.backgroundColor = .systemGray5
        scheduleTable.allowsSelection = false
    }

    func nextDayButtonConf() {
        var config = basicButtonConf(button: nextDayButton)
        config.title = R.string.localizable.next_day_button()
        nextDayButton.configuration = config
        nextDayButton.addTarget(self, action: #selector(nextDayButtonTapped), for: .touchUpInside)
    }

    func previousDayButtonConf() {
        var config = basicButtonConf(button: nextDayButton)
        config.title = R.string.localizable.previous_day_button()
        previousDayButton.configuration = config
        previousDayButton.addTarget(self, action: #selector(previousDayButtonTapped), for: .touchUpInside)
    }
}

private extension MainMenuView {
    @objc func nextDayButtonTapped() {
        self.nextDayAction?()
    }

    @objc func previousDayButtonTapped() {
        self.previousDayAction?()
    }
}
