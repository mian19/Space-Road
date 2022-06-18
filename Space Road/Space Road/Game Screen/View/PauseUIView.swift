//
//  PauseUIView.swift
//  Space Road
//
//  Created by Kyzu on 17.06.22.
//

import UIKit

class PauseUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setPauseView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setPauseView() {
        self.backgroundColor = .red
        self.layer.cornerRadius = 15
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        backgroundColor = UIColor.init(hex: "2596be")
    }

}
