//
//  TextField+RegistrationTF.swift
//  Space Road
//
//  Created by Kyzu on 6.06.22.
//

import UIKit

extension UITextField {
    static func registrationTF(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder.localizable()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.adjustsFontSizeToFitWidth = true
        textField.font = UIFont(name: "Play-Regular", size: 88)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 6
        textField.clipsToBounds = true
        return textField
    }
}
