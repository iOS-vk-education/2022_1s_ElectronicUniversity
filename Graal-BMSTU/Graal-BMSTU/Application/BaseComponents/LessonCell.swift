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
                return
            }
            subjectNameLabel.text = lesson.subject.name
            startTimeLabel.text = lesson.startTime
                    .formatted(.dateTime.hour(.defaultDigits(amPM: .omitted)).minute())
            finishTimeLabel.text = lesson.endTime
                    .formatted(.dateTime.hour(.defaultDigits(amPM: .omitted)).minute())
            placeLabel.text = lesson.place.name
            teacherLabel.text = lesson.teacher.name
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
    //    func resetData() {
    //        subjectNameLabel.text = nil
    //        startTimeLabel.text = nil
    //        finishTimeLabel.text = nil
    //        placeLabel.text = nil
    //        teacherLabel.text = nil
    //    }

    func setupUI() {
        self.backgroundColor = .white
        self.stack.axis = .vertical
        let elems = [subjectNameLabel, startTimeLabel, finishTimeLabel, placeLabel, teacherLabel]
        elems.forEach { box in
            self.stack.addSubview(box)
        }
        setupConstraints()
    }

    func setupConstraints() {
        stack.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
        }
        // inside stack...
    }
}

extension LessonCell {

}
