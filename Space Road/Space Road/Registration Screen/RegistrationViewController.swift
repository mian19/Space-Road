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
    private var alredyLabel: UILabel!
    private var authorizationButton: UIButton!

    override func loadView() {
        setView()
        setBackgroundImage()
        setTitleLabel()
        setNickNameTextField()
        setEmailTextField()
        setPasswordTextField()
        setRegistrateButton()
        setAlredyLabel()
        setAuthorizationButton()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    private func setView() {
        let custonView = UIView(frame: UIScreen.main.bounds)
        view = custonView
    }
    private func setBackgroundImage() {
        let backImageView = UIImageView(frame: view.frame)
        backImageView.image = UIImage(named: "registrationScreen")
        view.addSubview(backImageView)
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
    private func setNickNameTextField() {
        nickNameTextField = UITextField.registrationTF(placeholder: "nickNameTextField.placeholder")
        view.addSubview(nickNameTextField)
    }
    private func setEmailTextField() {
        emailTextField = UITextField.registrationTF(placeholder: "emailTextField.placeholder")
        view.addSubview(emailTextField)
    }
    private func setPasswordTextField() {
        passwordTextField = UITextField.registrationTF(placeholder: "passwordTextField.placeholder")
        view.addSubview(passwordTextField)
    }
    private func setRegistrateButton() {
        registrateButton = UIButton()
        registrateButton.translatesAutoresizingMaskIntoConstraints = false
        registrateButton.titleLabel?.adjustsFontSizeToFitWidth = true
        registrateButton.setTitle("registrateButton.text".localizable(), for: .normal)
        registrateButton.titleLabel?.font = UIFont(name: "Play-Bold", size: 20)
        registrateButton.setTitleColor(.white, for: .normal)
        registrateButton.backgroundColor = UIColor.init(hex: "1d54cc")
        registrateButton.layer.cornerRadius = 8
        registrateButton.clipsToBounds = true
        view.addSubview(registrateButton)
    }
    private func setAlredyLabel() {
        alredyLabel = UILabel()
        alredyLabel.text = "alredyLabel.title".localizable()
        alredyLabel.translatesAutoresizingMaskIntoConstraints = false
        alredyLabel.adjustsFontSizeToFitWidth = true
        alredyLabel.textColor = .white
        alredyLabel.textAlignment = .center
        alredyLabel.font = UIFont(name: "Play-Bold", size: 35)
        view.addSubview(alredyLabel)
    }
    private func setAuthorizationButton() {
        authorizationButton = UIButton()
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        authorizationButton.setTitle("authorizationButton.text".localizable(), for: .normal)
        authorizationButton.titleLabel?.font = UIFont(name: "Play-Bold", size: 22)
        authorizationButton.setTitleColor(UIColor.init(hex: "34cceb"), for: .normal)
        authorizationButton.backgroundColor = .none
        authorizationButton.layer.cornerRadius = 8
        authorizationButton.clipsToBounds = true
        view.addSubview(authorizationButton)
    }

    private func setElements() {
        NSLayoutConstraint.activate([
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 70),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nickNameTextField.widthAnchor.constraint(equalTo: titleLabel.widthAnchor),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 50),
            nickNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nickNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailTextField.widthAnchor.constraint(equalTo: nickNameTextField.widthAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nickNameTextField.heightAnchor),
            emailTextField.centerXAnchor.constraint(equalTo: nickNameTextField.centerXAnchor),
            emailTextField.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 15),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            registrateButton.widthAnchor.constraint(equalToConstant: 140),
            registrateButton.heightAnchor.constraint(equalToConstant: 50),
            registrateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrateButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30),
            alredyLabel.widthAnchor.constraint(equalTo: registrateButton.widthAnchor, multiplier: 1.2, constant: 0)  ,
            alredyLabel.heightAnchor.constraint(equalToConstant: 40),
            alredyLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            alredyLabel.topAnchor.constraint(equalTo: registrateButton.bottomAnchor, constant: 20),
            authorizationButton.topAnchor.constraint(equalTo: alredyLabel.topAnchor),
            authorizationButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            authorizationButton.leadingAnchor.constraint(equalTo: alredyLabel.trailingAnchor),
            authorizationButton.heightAnchor.constraint(equalTo: alredyLabel.heightAnchor)
            
        ])
    }

}
