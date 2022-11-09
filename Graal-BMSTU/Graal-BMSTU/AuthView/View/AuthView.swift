//
//  AuthView.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//

import UIKit
import SnapKit
import Rswift

protocol AuthViewDelegate: NSObjectProtocol
{
    func displaySuccessNotification(user: User?)
    func displayErrorNotification()
    func onViewDidLoad()
}

// Вьюконтроллер, показываемый на первом запуске + на вкладке "аккаунт", если человек не вошел в аккаунт
class AuthViewController: UIViewController, AuthViewDelegate {
    
    private let bmstuImage = UIImageView(frame: .zero)
    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)
    private let loginButton = UIButton(frame: .zero)
//    private let notificationView = GraalNotification(frame: .zero)
    private let loadingIndicator = UIActivityIndicatorView(frame: .zero)
    
    private let continueWithoutLoginButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!
    
    private let authViewPresenter = AuthViewPresenter(authService: AuthService())

    override func viewDidLoad()
    {
        super.viewDidLoad()
        authViewPresenter.setViewDelegate(authViewDelegate: self)
        authViewPresenter.setup()
    }
    
    
    func onViewDidLoad()
    {
        bmstuImage.image = R.image.bmstuLogo()
        loginField.placeholder = R.string.localizable.welcome()
        [bmstuImage, loginField, passwordField, loginButton, continueWithoutLoginButton].forEach { box in
            view.addSubview(box)
        }
        self.setupConstraints()
    }
    
    func displaySuccessNotification(user: User?)
    {
        // ...
        print("successfull auth")
    }
    
    func displayErrorNotification()
    {
        // ...
        print("unsuccessfull auth")
    }
    
    func setupConstraints()
    {
        bmstuImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 300))
            make.top.equalTo(self.view.snp.top).offset(0)
        }
        loginField.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        // ...
    }
    
    @objc func loginButtonPressed()
    {
        authViewPresenter.authenticate(username: loginField.text ?? "", password: passwordField.text ?? "")
    }
    
    func updateView()
    {
        // ...
    }
}
