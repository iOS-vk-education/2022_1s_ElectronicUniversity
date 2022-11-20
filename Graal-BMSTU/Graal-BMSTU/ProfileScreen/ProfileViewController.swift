//
//  ProfileViewController.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit


final class ProfileViewControllerImpl: UIViewController
{
    private var authView: AuthView = AuthView()
    private var profileView: ProfileView = ProfileView()
    
    private let presenter: ProfilePresenter
    private var nowActive: ProfileViewsVariants
    
    init(presenter: ProfilePresenter)
    {
        self.presenter = presenter
        nowActive = .profile
        super.init(nibName: nil, bundle: nil)
        presenter.updateUserdataFields()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileViewControllerImpl: ProfileViewController
{
    func showAuthError() {
        return
    }
    
    func setUserName(str: String)
    {
        if nowActive == .profile {
            profileView.updateUserName(with: str)
        }
    }
    
    func setUserGroup(str: String) {
        if nowActive == .profile
        {
            profileView.updateUserGroup(with: str)
        }
    }
    
    func setupUI()
    {
        if nowActive == .profile
        {
            profileView.setupUI()
        }
        else
        {
            authView.setupUI()
        }
    }
    
    func switchToProfile() {
        self.view = profileView
        profileView.setupUI()
    }
    
    func switchToAuth() {
        self.view = authView
        authView.setupUI()
    }
}

enum ProfileViewsVariants
{
    case profile
    case auth
}
