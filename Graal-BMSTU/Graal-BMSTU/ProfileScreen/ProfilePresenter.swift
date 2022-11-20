//
//  ProfilePresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import UIKit


final class ProfilePresenterImpl: ProfilePresenter
{
    
    weak var view: ProfileViewController?
    
    private var service: ProfileService?
    private let router: ProfileRouter
    
    init(router: ProfileRouter, service: ProfileService, view: ProfileViewController)
    {
        self.router = router
        self.service = service
        self.view = view
    }
    
    func load()
    {
        update()
    }
    
    func authenticate(username: String?, password: String?)
    {
        guard let username = username, let password = password else { return }
        if let _ = service?.authenticate(login: username, password: password)
        {
            view?.switchToProfile()
        }
        else
        {
            view?.showAuthError()

        }
    }
    
    func update()
    {
        let user: User? = service?.getUserData()
        if let user = user
        {
            view?.switchToProfile()
            view?.setUserName(str: user.name + " " + user.familyName)
            view?.setUserGroup(str: user.group)
        }
        else
        {
            view?.switchToAuth()
        }
    }
    
    func logout()
    {
        service?.logout()
        updateUserdataFields()
    }
}
