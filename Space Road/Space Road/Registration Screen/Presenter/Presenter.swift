//
//  Presenter.swift
//  Space Road
//
//  Created by Kyzu on 11.06.22.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

protocol RegistrationPresenterDelegate: AnyObject {
    func presentAlert(title: String, message: String)
    func toMain()
}

class RegistrationPresenter {
    weak var delegate: RegistrationPresenterDelegate?
    func checkUser(nick: String, email: String, pass: String) {
        if nick.isEmpty || email.isEmpty || pass.isEmpty {
            self.delegate?.presentAlert(title: "Attention", message: "Fill all fields")
        }
        if !nick.isEmpty && !email.isEmpty && !pass.isEmpty {
            Auth.auth().createUser(withEmail: email, password: pass) {(result, error) in
                if let error = error {
                    self.delegate?.presentAlert(title: "Attention!", message: error.localizedDescription)
                }
                if let result = result {
                    print(result.user.uid)
                    let ref = Database.database().reference().child("users")
                    ref.child(result.user.uid).updateChildValues(["nick": nick, "email": email])
                    // MARK: - save User to Keychain
                    KeychainManager.save(User(nick: nick, email: email, password: pass))
                    self.delegate?.toMain()
                }
            }
        }
    }
    func setViewDelegate(delegate: RegistrationPresenterDelegate) {
        self.delegate = delegate
    }
}
