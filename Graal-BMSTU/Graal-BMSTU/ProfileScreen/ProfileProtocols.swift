//
//  ProfileProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import Foundation


protocol ProfilePresenter
{
    init(router: ProfileRouter, service: ProfileService)
    func update()

    // MARK: - связка с сервисом, функции для вьюшки
    func authenticate(username: String?, password: String?)
    func logout()
}

protocol ProfileCoordinator: Coordinator
{

}

protocol ProfileViewController: AnyObject
{
    func switchToProfile()
    func switchToAuth()
    func showAuthError(description: String?)
    func setUserName(str: String)
    func setUserGroup(str: String)
}

protocol ProfileService
{
    func authenticate(login: String, password: String) -> User?
    func getUserData() -> User?
    func logout()
}

protocol ProfileBuilder
{
    
}
