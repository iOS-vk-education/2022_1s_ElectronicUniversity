//
// Created by Артём on 06.12.2022.
//

import UIKit

final class LessonCell: UITableViewCell {
    private var subjectNameLabel = UILabel(frame: .zero)
    private var startTimeLabel = UILabel(frame: .zero)
    private var finishTimeLabel = UILabel(frame: .zero)
    private var placeLabel = UILabel(frame: .zero)
    private var teacherLabel = UILabel(frame: .zero)
    private var stack = UIStackView(frame: .zero)
    var lesson: Lesson? {
        didSet {
            guard let lesson = lesson else {
                resetData()
                return
            }
            subjectNameLabel.text = lesson.subject.name
            startTimeLabel.text = lesson.startTime.formatted(
                    .dateTime.hour(.defaultDigits(amPM: .omitted)).minute())
            finishTimeLabel.text = lesson.endTime.formatted(
                    .dateTime.hour(.defaultDigits(amPM: .omitted)).minute())
            placeLabel.text = lesson.place.name
            teacherLabel.text = lesson.teacher?.displayName
        }
    }

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        return nil
    }
}

private extension LessonCell {
    func resetData() {
        subjectNameLabel.text = nil
        startTimeLabel.text = nil
        finishTimeLabel.text = nil
        placeLabel.text = nil
        teacherLabel.text = nil
    }

    func setupUI() {
        self.backgroundColor = .white
        setupStack()
        let elems = [subjectNameLabel, startTimeLabel, finishTimeLabel, placeLabel, teacherLabel]
        elems.forEach { box in
            stack.addArrangedSubview(box)
        }
        contentView.addSubview(stack)
        setupConstraints()
    }

    func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.left.equalTo(self.contentView.snp.left).offset(15)
            make.right.equalTo(self.contentView.snp.right).inset(15)
            make.top.equalTo(self.contentView.snp.top).offset(5)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(10)
        }
        //stack.distribution = .fillEqually
        //stack.spacing = 4
        //        subjectNameLabel.snp.makeConstraints { make in
        //            make.top.equalTo(self.contentView.snp.top).offset(5)
        //            make.left.equalTo(self.contentView.snp.left).offset(5)
        //            make.right.equalTo(self.contentView.snp.right).offset(5)
        //            make.height.equalTo(20)
        //        }
        //       startTimeLabel.snp.makeConstraints { make in
        //            make.top.equalTo(self.subjectNameLabel.snp.bottom).offset(5)
        //            make.left.equalTo(self.contentView.snp.left).offset(5)
        //            make.right.equalTo(self.contentView.snp.right).offset(5)
        //            make.height.equalTo(20)
        //        }
        //       finishTimeLabel.snp.makeConstraints { make in
        //           make.top.equalTo(self.startTimeLabel.snp.bottom).offset(5)
        //           make.left.equalTo(self.startTimeLabel.snp.left).offset(8)
        //           make.right.equalTo(self.contentView.snp.right).offset(5)
        //           make.height.equalTo(20)        }
        //       placeLabel.snp.makeConstraints { make in
        //            make.top.equalTo(self.finishTimeLabel.snp.bottom).offset(5)
        //            make.left.equalTo(self.contentView.snp.left).offset(5)
        //            make.right.equalTo(self.contentView.snp.right).offset(5)
        //            make.height.equalTo(20)
        //        }
        //        teacherLabel.snp.makeConstraints { make in
        //            make.top.equalTo(self.placeLabel.snp.bottom).offset(5)
        //            make.left.equalTo(self.contentView.snp.left).offset(5)
        //            make.right.equalTo(self.contentView.snp.right).offset(5)
        //            make.height.equalTo(20)
        //        }
    }
}

private extension LessonCell {
    func setupStack() {
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5,
                trailing: 5)
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 9
        stack.layer
             .maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        stack.backgroundColor = .systemYellow
    }
}
