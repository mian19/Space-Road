//
//  PilotViewController.swift
//  Space Road
//
//  Created by Kyzu on 30.06.22.
//

import UIKit

class PilotViewController: UIViewController, Storyboarded {

    private var titleLabel: UILabel!
    private var nickLabel: UILabel!
    private var emailLabel: UILabel!
    private var changePasswordButton: UIButton!
    private var homeButton: UIButton!
    private var user = KeychainManager().get()
    weak var appCoordinator: AppCoordinator?
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        view.backgroundColor = UIColor(patternImage: UIImage(named: "pilotScreen")!)
        setTitle()
        setButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()

    }
    
    private func setTitle() {
        titleLabel = UILabel.infoLabel(text: "pilotLabel.text".localizable(), size: 38, lines: 1)
        nickLabel = UILabel.infoLabel(text: user?.nick ?? "", size: 30, lines: 1)
        emailLabel = UILabel.infoLabel(text: user?.email ?? "", size: 30, lines: 1)
        view.addSubview(titleLabel)
        view.addSubview(nickLabel)
        view.addSubview(emailLabel)
    }
    
    private func setButtons() {
        homeButton = UIButton.systemButton(image: "home")
        homeButton.addTarget(self, action: #selector(onHomeButton), for: .touchUpInside)
      
        view.addSubview(homeButton)
    }
    
    @objc func onHomeButton() {
        appCoordinator?.back()
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 150),
            titleLabel.widthAnchor.constraint(equalToConstant: 280),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nickLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            nickLabel.heightAnchor.constraint(equalToConstant: 100),
            nickLabel.widthAnchor.constraint(equalToConstant: 280),
            nickLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: nickLabel.bottomAnchor, constant: 20),
            emailLabel.heightAnchor.constraint(equalToConstant: 100),
            emailLabel.widthAnchor.constraint(equalToConstant: 280),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 20),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
