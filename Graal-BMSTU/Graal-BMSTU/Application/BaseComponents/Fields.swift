//
// Created by Артём on 04.12.2022.
//

import UIKit

func basicTextFieldConf(field: UITextField) {
    field.clearButtonMode = .whileEditing
    field.borderStyle = UITextField.BorderStyle.roundedRect
    field.layer.borderWidth = 1.5
    field.layer.borderColor = CGColor.init(red: 0.2, green: 0.5, blue: 0.8, alpha: 0.4)
    field.layer.shadowRadius = 1.0
    field.layer.shadowOffset = CGSizeMake(1.0, 1.0)
    field.layer.shadowOpacity = 1.0
    field.textAlignment = .center
}
