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
    func start()
}
