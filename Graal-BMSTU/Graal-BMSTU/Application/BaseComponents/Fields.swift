//
// Created by Артём on 04.12.2022.
//

import UIKit

func basicTextFieldConf(field: UITextField) {
    field.layer.cornerRadius = 2.0
    field.borderStyle = UITextField.BorderStyle.none
    field.layer.masksToBounds = false
    field.layer.borderWidth = 0.0; field.layer.borderColor = CGColor.init(red: 255 / 255,
            green: 250 / 255, blue: 250 / 255, alpha: 1)
    field.layer.shadowColor = CGColor.init(red: 177 / 255, green: 174 / 255, blue: 168 / 255,
            alpha: 0.8)
    field.layer.shadowRadius = 5.0
    field.layer.shadowOffset = CGSizeMake(0.0, 0.0)
    field.layer.shadowOpacity = 0.9
    field.backgroundColor = .init(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 1.0)
}
