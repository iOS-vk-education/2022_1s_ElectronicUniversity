//
//  AuthView.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//


import UIKit
import SnapKit
import Rswift
import SFSafeSymbols

protocol AuthPresenter {
    func authenticate(login: String?, password: String?)
    func onViewDidLoad()
}

protocol AuthViewControllerPr: AnyObject {
    func displaySuccessNotification()
    func displayErrorNotification()
}

typealias LoginAction = (String?, String?) -> Void

// Вьюконтроллер, показываемый на первом запуске + на вкладке "аккаунт", если человек не вошел в аккаунт

final class AuthViewController: UIViewController, AuthViewControllerPr {
    private let authViewPresenter: AuthPresenter
    private var authView: AuthView?

    init(authViewPresenter: AuthPresenter) {
        self.authViewPresenter = authViewPresenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        authView = AuthView()
        setupActions()
        authView?.setupUI()
        authViewPresenter.onViewDidLoad()
        loadView()
        view.backgroundColor = UIColor.clear
    }

    private func setupActions() {
        authView?.setLoginAction(authViewPresenter.authenticate)
    }

    override func loadView() {
        view = authView

    }


    func displaySuccessNotification() {
        // ...
        print("successfull auth")
    }

    func displayErrorNotification() {
        // ...
        print("unsuccessfull auth")
    }


    func updateView() {
        // ...
    }
}


final class AuthView: UIView {

    private let bmstuImage = UIImageView(frame: .zero)
    private let loginField = UITextField(frame: .zero)
    private let passwordField = UITextField(frame: .zero)
    private var loginButton = UIButton(frame: .zero)
    private var logoutButton = UIButton(frame: .zero)
    private let label = UILabel()


    //    private let notificationView = GraalNotification(frame: .zero)

    private let continueWithoutLoginButton = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!
    private let continueWithoutLogoutButton = UIButton(frame: .zero)

    private var loginAction: LoginAction?
}

extension AuthView {
    // actions
    func setLoginAction(_ action: @escaping LoginAction) {
        self.loginAction = action
    }

    @objc private func loginButtonPressed() {
        if let action = self.loginAction {
            action(loginField.text, passwordField.text)
        }
    }

    @objc private func logoutButtonPressed() {

    }
}

extension AuthView {
    // UI

    private func createLoginButton() -> UIButton {
        var loginButton = UIButton(type: .system)
        loginButton.backgroundColor = UIColor.systemBlue
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 20
        loginButton.setTitle("Войти", for: .normal)

        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)


        /*loginButtonConfig.buttonSize = .large
           loginButtonConfig.cornerStyle = .medium
           loginButtonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer
           { incoming in
               var outgoing = incoming
               outgoing.font = UIFont.preferredFont(forTextStyle: .headline)
               return outgoing
           }
           loginButtonConfig.title = R.string.localizable.login_button_text()
           loginButtonConfig.titlePadding = 5
           loginButtonConfig.image = UIImage(systemSymbol: .chevronRight)
           loginButtonConfig.imagePadding = 5
           loginButtonConfig.imagePlacement = .trailing
           loginButtonConfig.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(scale: .medium)*/
        return loginButton
    }

    @objc private func loginButtonTapped() {
        print("unsuccessfull auth")
    }

    private func createLogoutButton() -> UIButton {
        var loginButton = UIButton(type: .system)
        logoutButton.backgroundColor = UIColor.systemBlue
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.layer.cornerRadius = 20
        logoutButton.setTitle("Продолжить без вхда", for: .normal)

        logoutButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)


        return logoutButton
    }

    @objc private func logoutButtonTapped() {
        print("successfull auth")
    }


    func setupUI() {
        bmstuImage.image = R.image.bmstuLogo()
        loginField.placeholder = R.string.localizable.login_field_placeholder()
        passwordField.placeholder = R.string.localizable.password_field_placeholder()

        loginButton = createLoginButton()
        // loginButton.addTarget(self, action: #selector(self.loginButtonPressed), for: .touchUpInside)
        [bmstuImage, loginField, passwordField, loginButton, continueWithoutLoginButton, logoutButton].forEach { box in
            self.addSubview(box)
        }
        self.setupConstraints()
    }

    private func setupConstraints() {
        bmstuImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
        }

        loginField.snp.makeConstraints { make in
            make.top.equalTo(bmstuImage.snp.bottom).offset(120)
            make.centerX.equalToSuperview()
        }

        passwordField.snp.makeConstraints { make in
            make.top.equalTo(loginField.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }

        loginButton.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(30)
            make.top.equalTo(passwordField.snp.bottom).offset(30)
            make.height.equalTo(50)
        }

        logoutButton.snp.makeConstraints { make in
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).inset(30)
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.height.equalTo(50)
        }
    }
}
