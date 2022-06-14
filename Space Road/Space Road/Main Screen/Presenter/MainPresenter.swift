//
//  Presenter.swift
//  Space Road
//
//  Created by Kyzu on 13.06.22.
//

import Foundation
import FirebaseAuth

protocol MainPresenterDelegate: AnyObject {
    var appCoordinator: AppCoordinator? {get set}
}

class MainPresenter {
    
    weak var delegate: MainPresenterDelegate?
    func logout() {
        do {
            try Auth.auth().signOut()
            KeychainManager.shared.delete()
            self.delegate?.appCoordinator?.toRegistrationScreen()
        } catch {
            print(error)
        }
    }
    
    func setViewDelegate(delegate: MainPresenterDelegate) {
        self.delegate = delegate
    }
}
