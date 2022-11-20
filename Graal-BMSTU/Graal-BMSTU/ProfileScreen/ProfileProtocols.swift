//
//  ProfileProtocols.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import Foundation


protocol ProfilePresenter
{
    init(router: ProfileRouter, service: ProfileService, view: ProfileViewController)
    func update()
    // MARK: - связка с сервисом
    func authenticate(username: String?, password: String?)
    func logout()
}

protocol ProfileRouter: AnyObject
{
    func continueWithAccount()
    func continueWithoutAccount()
    
}

protocol ProfileViewController: AnyObject
{
    func switchToProfile()
    func switchToAuth()
    func showAuthError()
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
