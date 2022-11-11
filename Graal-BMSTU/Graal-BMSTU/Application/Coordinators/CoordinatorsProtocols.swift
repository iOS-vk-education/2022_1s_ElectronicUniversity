//
//  CoordinatorProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import Foundation

protocol AppCoordinatorProtocol
{
    func startAuthScenario()
    func startMainScenario()
}

protocol CoordinatorProtocol
{
    func start()
}
