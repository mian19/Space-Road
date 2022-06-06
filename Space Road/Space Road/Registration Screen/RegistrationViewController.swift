//
//  RegistrationViewController.swift
//  Space Road
//
//  Created by Kyzu on 4.06.22.
//

import UIKit

class RegistrationViewController: UIViewController {

    private var titleLabel: UILabel!
    private var nickNameTextField: UITextField!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var registrateButton: UIButton!
    private var loginButton: UIButton?

    override func loadView() {
        setView()
        setBackgroundImage()
        setTitleLabel()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    private func setView() {
        let custonView = UIView(frame: UIScreen.main.bounds)
        view = custonView
    }
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "titleLabel.title".localizable()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Play-Bold", size: 105)
        view.addSubview(titleLabel)
    }
    private func setBackgroundImage() {
        let backImageView = UIImageView(frame: view.frame)
        backImageView.image = UIImage(named: "registrationScreen")
        view.addSubview(backImageView)
    }
    private func setElements() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 140),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)

        ])
    }

}
