//
//  AuthPresenter.swift
//  Graal-BMSTU
//
//  Created by Артём on 09.11.2022.
//

import UIKit

class AuthViewPresenter
{
    private let authService: AuthService
    weak private var authViewDelegate: AuthViewDelegate?
    
    init(authService: AuthService)
    {
        self.authService = authService
    }
    
    func setup()
    {
        authViewDelegate?.onViewDidLoad(titleImageSrc: "BMSTU Logo")
    }
    
    func setViewDelegate(authViewDelegate: AuthViewDelegate)
    {
        self.authViewDelegate = authViewDelegate
    }
    
    func authenticate(username: String, password: String)
    {
        authService.authenticate(login: username, password: password)
        {
            [weak self] user in
            if let user
            {
                self?.authViewDelegate?.displaySuccessNotification(user: user)
            }
            else
            {
                self?.authViewDelegate?.displayErrorNotification()
            }
        }
    }
}
