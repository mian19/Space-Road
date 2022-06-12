//
//  ViewController.swift
//  Space Road
//
//  Created by Kyzu on 4.06.22.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController, Storyboarded {
    var button: UIButton!
    weak var appCoordinator: AppCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        button.backgroundColor = .white
        view.addSubview(button)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    @objc func logout() {
        do {
            try Auth.auth().signOut()
            KeychainManager.shared.delete()
            appCoordinator?.toRegistrationScreen()
        } catch {
            print(error)
        }
    }

}
