//
//  CoordinatorProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

protocol Coordinator: AnyObject {
    init(window: UIWindow, navigationController: UINavigationController)
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
