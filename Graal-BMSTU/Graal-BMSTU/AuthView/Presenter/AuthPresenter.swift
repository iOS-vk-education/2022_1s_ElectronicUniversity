//
//  AuthPresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import Foundation


final class AuthViewPresenterImpl: AuthPresenter
{
        
    private let authService: AuthService
    weak var viewController: AuthViewControllerPr?
    init(authService: AuthService)
    {
        self.authService = authService
    }

    func authenticate(login username: String?, password: String?)
    {
        authService.authenticate(login: username ?? "", password: password ?? "")
        {
            [weak self] user in
            if user != nil
            {
                self?.viewController?.displaySuccessNotification()
            }
            else
            {
                self?.viewController?.displayErrorNotification()
            }
        }
    }
    
    func onViewDidLoad() {
        return
    }
}
