//
//  ProfilePresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation

final class ProfilePresenterImpl: ProfilePresenter
{
    weak var view: ProfileViewController?
    private var authService: AuthService?
    private let router: ProfileRouter

    
    init(router: ProfileRouter)
    {
        self.router = router
    }
    

    
    func authenticate(username: String?, password: String?)
    {
        guard let username = username, let password = password else { return }
        authService?.authenticate(login: username, password: password)
        {
            [weak self] user in
            if user != nil
            {
                // success
            }
            else
            {
                // error
            }
        }
    }
}
