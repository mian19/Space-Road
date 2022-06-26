//
//  SettingsViewController.swift
//  Space Road
//
//  Created by Kyzu on 20.06.22.
//

import UIKit

class SettingsViewController: UIViewController, Storyboarded, SettingsPresenterDelegate {

    private var titleLabel: UILabel!
    private var difficultyLevelLabel: UILabel!
    private var levelSegmentedControl: UISegmentedControl!
    private var soundLabel: UILabel!
    private var soundSegmentControll: UISegmentedControl!
    private var homeButton: UIButton!
    private var settings = UserDefaultsManager().getSettings()
    private let presenter = SettingsPresenter()
    weak var appCoordinator: AppCoordinator?
    var difficulties = ["diff.easy".localizable(), "diff.medium".localizable(), "diff.hard".localizable()]
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "settingsScreen")!)
        view = customView
        setTitle()
        setButton()
        setLevelControlled()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
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
    
    private func setLevelControlled() {
        levelSegmentedControl = UISegmentedControl(items: self.difficulties)
        levelSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 18)
        levelSegmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        levelSegmentedControl.backgroundColor = .gray
        levelSegmentedControl.selectedSegmentIndex = UserDefaultsManager().getSettings().difficulty
        levelSegmentedControl.addTarget(self, action: #selector(onLevelSegmentedControl), for: .valueChanged)
        view.addSubview(levelSegmentedControl)
    }
    
    @objc func onLevelSegmentedControl(target: UISegmentedControl) {
        var settings = UserDefaultsManager().getSettings()
        let segmentIndex = target.selectedSegmentIndex
        settings.difficulty = segmentIndex
        UserDefaultsManager().saveSettings(settings: settings)
        print(segmentIndex)
        
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
            levelSegmentedControl.widthAnchor.constraint(equalToConstant: 280),
            levelSegmentedControl.heightAnchor.constraint(equalToConstant: 70),
            levelSegmentedControl.topAnchor.constraint(equalTo: difficultyLevelLabel.bottomAnchor, constant: 30),
            levelSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 30),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
