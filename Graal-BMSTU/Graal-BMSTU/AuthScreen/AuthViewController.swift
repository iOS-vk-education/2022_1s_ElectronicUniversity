//
//  AuthViewController.swift
//  Graal-BMSTU
//
//  Created by Артём on 11.11.2022.
//

import UIKit

// Вьюконтроллер, показываемый на первом запуске + на вкладке "аккаунт", если человек не вошел в аккаунт
final class AuthViewController: UIViewController, AuthViewControllerPr
{
    private let authViewPresenter: AuthPresenter
    private var authView: AuthView = AuthView()
    
    init(authViewPresenter: AuthPresenter)
    {
        self.authViewPresenter = authViewPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        return nil
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupActions()
        authView.setupUI()
        authViewPresenter.onViewDidLoad()
        loadView()
    }
    
    private func setupActions()
    {
        authView.setLoginAction(authViewPresenter.authenticate)
    }
    
    override func loadView()
    {
        view = authView
    }
    
    
    func displaySuccessNotification()
    {
        // ...
        print("successfull auth")
    }
    
    func displayErrorNotification()
    {
        // ...
        print("unsuccessfull auth")
    }
    
    
    func updateView()
    {
        // ...
    }
}
