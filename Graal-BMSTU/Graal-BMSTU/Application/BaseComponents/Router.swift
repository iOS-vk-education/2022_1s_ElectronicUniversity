//
// Created by Артём on 07.12.2022.
//

import UIKit

protocol Router {
    init(window: UIWindow, navigationController: UINavigationController)
    var parentRouter: Router? { get set }
    func start()
    func setVC(vc: UIViewController)
}

extension Router {
}