//
//  AppCoordinator.swift
//  Space Road
//
//  Created by Kyzu on 9.06.22.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseAuth

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        FirebaseApp.configure()
        Auth.auth().addStateDidChangeListener{(auth, user ) in
            if user == nil {
                self.toRegistrationScreen()
            } else {
                self.toMainScreen()
            }
        }
    }
    
    func toRegistrationScreen() {
        let storyboard = UIStoryboard(name: "RegistrationViewController", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? RegistrationViewController ?? UIViewController()
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func toMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? MainViewController ?? UIViewController()
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    
}
