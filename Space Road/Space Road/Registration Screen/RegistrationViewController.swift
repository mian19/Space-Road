//
//  RegistrationViewController.swift
//  Space Road
//
//  Created by Kyzu on 4.06.22.
// swiftlint:disable line_length
// // swiftlint:disable all

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    private var scrollView: UIScrollView!
    private var backImageView: UIImageView!
    private var titleLabel: UILabel!
    private var nickNameTextField: UITextField!
    private var emailTextField: UITextField!
    private var passwordTextField: UITextField!
    private var registrateButton: UIButton!
    private var loginButton: UIButton?
    private var alredyLabel: UILabel!
    private var authorizationButton: UIButton!
    private var isExpand = false

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
        self.navigationController?.navigationBar.isHidden = true
        registerForKeyboardNotifications()
        setElements()
        nickNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardAppear(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
             let keyboardHeight = keyboardSize.height
            let offset = view.frame.maxY - registrateButton.frame.maxY
            if keyboardHeight > offset {
                self.scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight - offset)
            }
         }
    }
    @objc func keyboardDisappear() {
        scrollView.contentOffset = CGPoint.zero
    }
    
    private func setView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(focus)))
        view.addSubview(scrollView)
    }
    private func setBackgroundImage() {
        backImageView = UIImageView()
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.image = UIImage(named: "registrationScreen")
        backImageView.contentMode = .scaleAspectFill
        scrollView.addSubview(backImageView)
    }
    private func setTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "titleLabel.title".localizable()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Play-Bold", size: 105)
        scrollView.addSubview(titleLabel)
    }
    private func setNickNameTextField() {
        nickNameTextField = UITextField.registrationTF(placeholder: "nickNameTextField.placeholder")
        nickNameTextField.autocorrectionType = .no
        scrollView.addSubview(nickNameTextField)
    }
    private func setEmailTextField() {
        emailTextField = UITextField.registrationTF(placeholder: "emailTextField.placeholder")
        emailTextField.keyboardType = .emailAddress
        emailTextField.textContentType = .emailAddress
        scrollView.addSubview(emailTextField)
    }
    private func setPasswordTextField() {
        passwordTextField = UITextField.registrationTF(placeholder: "passwordTextField.placeholder")
        scrollView.addSubview(passwordTextField)
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
        scrollView.addSubview(registrateButton)
    }
    private func setAlredyLabel() {
        alredyLabel = UILabel()
        alredyLabel.text = "alredyLabel.title".localizable()
        alredyLabel.translatesAutoresizingMaskIntoConstraints = false
        alredyLabel.adjustsFontSizeToFitWidth = true
        alredyLabel.textColor = .white
        alredyLabel.textAlignment = .center
        alredyLabel.font = UIFont(name: "Play-Bold", size: 28)
        scrollView.addSubview(alredyLabel)
    }
    private func setAuthorizationButton() {
        authorizationButton = UIButton()
        authorizationButton.translatesAutoresizingMaskIntoConstraints = false
        authorizationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        authorizationButton.setTitle("authorizationButton.text".localizable(), for: .normal)
        authorizationButton.titleLabel?.font = UIFont(name: "Play-Bold", size: 28)
        authorizationButton.setTitleColor(UIColor.init(hex: "34cceb"), for: .normal)
        authorizationButton.backgroundColor = .none
        authorizationButton.layer.cornerRadius = 8
        authorizationButton.clipsToBounds = true
        scrollView.addSubview(authorizationButton)
    }
    @objc private func focus(){
        scrollView.endEditing(true)
    }

    private func setElements() {
        NSLayoutConstraint.activate([
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            backImageView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 250),
            titleLabel.heightAnchor.constraint(equalToConstant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 100),
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
            alredyLabel.widthAnchor.constraint(equalTo: registrateButton.widthAnchor, multiplier: 1, constant: 0)  ,
            alredyLabel.heightAnchor.constraint(equalToConstant: 40),
            alredyLabel.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            alredyLabel.topAnchor.constraint(equalTo: registrateButton.bottomAnchor, constant: 30),
            authorizationButton.topAnchor.constraint(equalTo: alredyLabel.topAnchor),
            authorizationButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            authorizationButton.leadingAnchor.constraint(equalTo: alredyLabel.trailingAnchor),
            authorizationButton.heightAnchor.constraint(equalTo: alredyLabel.heightAnchor)
        ])
    }

}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nick = nickNameTextField.text!
        let email = emailTextField.text!
        let pass = passwordTextField.text!
        
        if (!nick.isEmpty && !email.isEmpty && !pass.isEmpty) {
            Auth.auth().createUser(withEmail: email, password: pass) {(result, error) in
                if error == nil {
                    if let result = result {
                        
                     print(result.user.uid)
                    let ref = Database.database().reference().child("users")
                        ref.child(result.user.uid).updateChildValues(["nick": nick, "email": email])
                }
                                                                  }
            }
        }
        
        return true
    }
}
