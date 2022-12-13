//
// Created by Артём on 06.12.2022.
//

import UIKit

final class LessonTile: UITableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        self.accessoryType = .none
    }
    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentConfiguration = contentConf()
        self.backgroundConfiguration = backgroundConf()
    }
}

extension LessonTile {
    func contentConf() -> UIContentConfiguration {
        var config = defaultContentConfiguration()
    }

    func backgroundConf() -> UIBackgroundConfiguration {

    }
}
