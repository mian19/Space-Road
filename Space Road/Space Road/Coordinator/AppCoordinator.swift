//
//  AppCoordinator.swift
//  Space Road
//
//  Created by Kyzu on 9.06.22.
//

import Foundation
import UIKit

class AppCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        if KeychainManager.shared.get() != nil {
            toMainScreen()
        } else {
            toRegistrationScreen()
        }
    }
    func toRegistrationScreen() {
        let viewController = RegistrationViewController.createObject()
        viewController.appCoordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
    func toMainScreen() {
        let viewController = MainViewController.createObject()
        viewController.appCoordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
}
