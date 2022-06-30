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
    private var soundSegmentControl: UISegmentedControl!
    private var homeButton: UIButton!
    private let presenter = SettingsPresenter()
    weak var appCoordinator: AppCoordinator?
    var levelSegmentIndex: Int?
    var soundSegmentIndex: Int?
    var difficulties = ["diff.easy".localizable(), "diff.medium".localizable(), "diff.hard".localizable()]
    var sound = ["sound.on".localizable(), "sound.off".localizable()]
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "settingsScreen")!)
        view = customView
        setTitle()
        setButton()
        setLevelControlled()
        setSoundSegmentControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        setElements()

    }
    
    private func setTitle() {
        titleLabel = UILabel.infoLabel(text: "titleLabel.text".localizable(), size: 38, lines: 1)
        difficultyLevelLabel = UILabel.infoLabel(text: "difficultyLevel.text".localizable(), size: 28, lines: 1)
        soundLabel = UILabel.infoLabel(text: "sound.text".localizable(), size: 28, lines: 1)
        view.addSubview(titleLabel)
        view.addSubview(difficultyLevelLabel)
        view.addSubview(soundLabel)
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
    
    private func setSoundSegmentControl() {
        soundSegmentControl = UISegmentedControl(items: self.sound)
        soundSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 20)
        soundSegmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        soundSegmentControl.backgroundColor = .gray
        soundSegmentControl.selectedSegmentIndex = UserDefaultsManager().getSettings().sounds
        soundSegmentControl.addTarget(self, action: #selector(onSoundSegmentControl), for: .valueChanged)
        view.addSubview(soundSegmentControl)
    }
    
    @objc func onLevelSegmentedControl(target: UISegmentedControl) {
        levelSegmentIndex = target.selectedSegmentIndex
        
    }
    
    @objc func onSoundSegmentControl(target: UISegmentedControl) {
        soundSegmentIndex = target.selectedSegmentIndex
    }
    
    @objc func onHomeButton() {
        presenter.saveSettings(diff: levelSegmentIndex, sound: soundSegmentIndex)
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            titleLabel.heightAnchor.constraint(equalToConstant: 150),
            titleLabel.widthAnchor.constraint(equalToConstant: 280),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            difficultyLevelLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            difficultyLevelLabel.heightAnchor.constraint(equalToConstant: 70),
            difficultyLevelLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            difficultyLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            levelSegmentedControl.widthAnchor.constraint(equalToConstant: 280),
            levelSegmentedControl.heightAnchor.constraint(equalToConstant: 70),
            levelSegmentedControl.topAnchor.constraint(equalTo: difficultyLevelLabel.bottomAnchor, constant: 30),
            levelSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            soundLabel.heightAnchor.constraint(equalToConstant: 70),
            soundLabel.topAnchor.constraint(equalTo: levelSegmentedControl.bottomAnchor, constant: 30),
            soundSegmentControl.widthAnchor.constraint(equalToConstant: 180),
            soundSegmentControl.heightAnchor.constraint(equalToConstant: 70),
            soundSegmentControl.topAnchor.constraint(equalTo: soundLabel.bottomAnchor, constant: 30),
            soundSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 20),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
