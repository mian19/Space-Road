//
//  UILabel+customLabel.swift
//  Space Road
//
//  Created by Kyzu on 13.06.22.
//

import Foundation
import UIKit

extension UILabel {
    
    static func infoLabel(text: String, size: Int, lines: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "KenVector Future Regular", size: CGFloat(size))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = lines
        label.text = text
        return label
    }
    
    static func scoreLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Play-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Score:0"
        return label
    }
}
