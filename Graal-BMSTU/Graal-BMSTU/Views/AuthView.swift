//
//  AuthView.swift
//  Graal-BMSTU
//
//  Created by Артём on 03.11.2022.
//

import UIKit
import SnapKit


// Вьюконтроллер, показываемый на первом запуске + на вкладке "аккаунт", если человек не вошел в аккаунт
class AuthView: UIViewController {
    var bmstuImage: UIImageView = UIImageView(frame: .zero)
    var loginField: UITextField! = UITextField(frame: .zero)
    var passwordField: UITextField! = UITextField(frame: .zero)
    var loginButton: UIButton! = UIButton(frame: .zero)
    var continueWithoutLoginButton: UIButton! = UIButton(frame: .zero) // только при первом запуске есть такая кнопка!
    // "Notification" view? Может его отдельным классом прямо?
    // "loading..." view? каким классом? картинка?
    
    // можно прямо на месте заполнять данными (вычисляемые переменные):
//    lazy var titleLabel: UILabel = {
//           let label = UILabel()
//           label.text = "Profile"
//           label.font = .boldSystemFont(ofSize: 24)
//           label.textAlignment = .center
//           return label
//       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        // тут заполняем вьюшки данными. наверное, стоит в отдельную функцию? может это вообще презентер делает?? но тут нет получения данных из модели...
        
        // UIImage(imageLiteralResourceName: "BMSTU Logo")
        
        [loginField, passwordField, loginButton, continueWithoutLoginButton].forEach { box in
            view.addSubview(box)
        }
        
        // а вот тут позиционируем вьюшки (snapkit)
    }
    
    func updateView()
    {
        // отрабатываем вызов от презентера..?
    }
}
