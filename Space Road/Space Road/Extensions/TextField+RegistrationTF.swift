//
//  TextField+RegistrationTF.swift
//  Space Road
//
//  Created by Kyzu on 6.06.22.
// swiftlint:disable line_length

import UIKit

extension UITextField {
    
    static func registrationTF(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.adjustsFontSizeToFitWidth = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .alphabet
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.returnKeyType = .done
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: placeholder.localizable(), attributes: [.foregroundColor: UIColor.gray])
        textField.layer.cornerRadius = 6
        textField.clipsToBounds = true
        return textField
    }
}
