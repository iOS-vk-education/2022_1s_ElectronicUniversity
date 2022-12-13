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


