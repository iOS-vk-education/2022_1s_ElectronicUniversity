//
//  AuthView.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//

import UIKit
import SnapKit
import Rswift

protocol AuthPresenter
{
    func authenticate(login: String?, password: String?)
    func onViewDidLoad()
}

protocol AuthViewControllerPr: AnyObject
{
    func displaySuccessNotification()
    func displayErrorNotification()
}

typealias LoginAction = (String?, String?) -> Void

// Вьюконтроллер, показываемый на первом запуске + на вкладке "аккаунт", если человек не вошел в аккаунт
final class AuthViewController: UIViewController, AuthViewControllerPr
{
    private let authViewPresenter: AuthPresenter
    private var authView: AuthView?
    
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
        authView = AuthView()
        setupActions()
        authView?.setupUI()
        loadView()
    }
    
    private func setupActions()
    {
        authView?.setLoginAction(authViewPresenter.authenticate)
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


final class AuthView: UIView
{
    private let bmstuImage = UIImageView(frame: .zero)
    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)
    private let loginButton = UIButton(frame: .zero)
    private let loadingIndicator = UIActivityIndicatorView(frame: .zero)
    //    private let notificationView = GraalNotification(frame: .zero)
    
    private let continueWithoutLoginButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!
    
    private var loginAction: LoginAction?
}

extension AuthView
{
    // actions
    func setLoginAction(_ action: @escaping LoginAction)
    {
        self.loginAction = action
    }
    
    @objc private func loginButtonPressed()
    {
        if let action = self.loginAction { action(loginField.text, passwordField.text) }
    }
}

extension AuthView
{
    // UI
    func setupUI()
    {
        bmstuImage.image = R.image.bmstuLogo()
        loginField.placeholder = R.string.localizable.welcome()
        [bmstuImage, loginField, passwordField, loginButton, continueWithoutLoginButton].forEach
        { box in
            self.addSubview(box)
        }
        self.setupConstraints()
    }
    
    private func setupConstraints()
    {
        bmstuImage.snp.makeConstraints
        { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50)
        }
        loginField.snp.makeConstraints
        { make in
            make.top.equalTo(bmstuImage.snp.top).offset(50)
            make.center.equalToSuperview()
        }
        passwordField.snp.makeConstraints
        { make in
            make.top.equalTo(loginField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
}
