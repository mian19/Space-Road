//
//  UIBuon+CustomButton.swift
//  Space Road
//
//  Created by Kyzu on 13.06.22.
//

import Foundation
import UIKit

extension UIButton {
    static func systemButton(image: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let backImage = UIImage(named: image)
        button.setBackgroundImage(backImage, for: .normal)
        return button
    }
    static func withTextButton(with text: String, size: CGFloat) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.tintAdjustmentMode = .automatic
        button.backgroundColor = UIColor.init(hex: "#f2f5fc")
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont(name: "KenVector Future Regular", size: size)
        button.setTitleColor(UIColor.init(hex: "#0b379e"), for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }
}
