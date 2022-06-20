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
    
    private func alredyInStack(checkedViewController: UIViewController) -> Bool {
        ((self.navigationController.viewControllers.filter {$0 == checkedViewController}).count != 0)
    }
    
    func toRegistrationScreen() {
        let viewController = RegistrationViewController.createObject()
        if alredyInStack(checkedViewController: viewController) {
            self.navigationController.popToViewController(viewController, animated: true)
        } else {
            viewController.appCoordinator = self
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func toMainScreen() {
        let viewController = MainViewController.createObject()
        if alredyInStack(checkedViewController: viewController) {
            self.navigationController.popToViewController(viewController, animated: true)
        } else {
            viewController.appCoordinator = self
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func back() {
        self.navigationController.popViewController(animated: true)
    }
    
    func toGameScreen() {
        let viewController = GameViewController.createObject()
        viewController.appCoordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func toShuttleScreen() {
        let viewController = ShuttleViewController.createObject()
        viewController.appCoordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func toSettingsScreen() {
        let viewController = SettingsViewController.createObject()
        viewController.appCoordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
