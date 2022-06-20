//
//  SettingsViewController.swift
//  Space Road
//
//  Created by Kyzu on 20.06.22.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded {

    private var titleLabel: UILabel!
    private var difficultyLevelLabel: UILabel!
    private var levelSegmentedControll: UISegmentedControl!
    private var soundLabel: UILabel!
    private var soundSegmentControll: UISegmentedControl!
    private var homeButton: UIButton!
    private var settings = UserDefaultsManager().getSettings()
    weak var appCoordinator: AppCoordinator?
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "settingsScreen")!)
        view = customView
        setTitle()
        setButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()

    }
    
    private func setTitle() {
        titleLabel = UILabel.infoLabel(text: "titleLabel.text".localizable(), size: 38, lines: 1)
        difficultyLevelLabel = UILabel.infoLabel(text: "difficultyLevel.text".localizable(), size: 28, lines: 1)
        view.addSubview(titleLabel)
        view.addSubview(difficultyLevelLabel)
    }
    
    private func setButton() {
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
            difficultyLevelLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            difficultyLevelLabel.heightAnchor.constraint(equalToConstant: 70),
            difficultyLevelLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            difficultyLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 30),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }


}
