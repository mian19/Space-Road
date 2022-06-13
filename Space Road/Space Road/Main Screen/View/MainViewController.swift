//
//  ViewController.swift
//  Space Road
//
//  Created by Kyzu on 4.06.22.
//

import UIKit

class MainViewController: UIViewController, MainPresenterDelegate, Storyboarded {
    
    private var helloLabel: UILabel!
    private var startButton: UIButton!
    private var settingsButton: UIButton!
    private var recordsButton: UIButton!
    private var shuttleButton: UIButton!
    private var infoButton: UIButton!
    private var exitButton: UIButton!
    private var pilotButton: UIButton!
    private let presenter = MainPresenter()
    weak var appCoordinator: AppCoordinator?
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "mainScreen")!)
        view = customView
        setTitle()
        setButtons()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.presenter.setViewDelegate(delegate: self)
        setElements()
    }
    private func setTitle() {
        helloLabel = UILabel.infoLabel(text: "helloLabel.text".localizable(), size: 38, lines: 2)
        view.addSubview(helloLabel)
    }
    private func setButtons() {
        startButton = UIButton.withTextButton(with: "startButton.text".localizable(), size: 38)
        settingsButton = UIButton.systemButton(image: "gear")
        recordsButton = UIButton.systemButton(image: "leaderboardsComplex")
        shuttleButton = UIButton.systemButton(image: "choseShip")
        infoButton = UIButton.systemButton(image: "information")
        pilotButton = UIButton.systemButton(image: "pilot")
        exitButton = UIButton.systemButton(image: "exit")
        exitButton.addTarget(self, action: #selector(onExitButton), for: .touchUpInside)
        view.addSubview(startButton)
        view.addSubview(settingsButton)
        view.addSubview(recordsButton)
        view.addSubview(shuttleButton)
        view.addSubview(infoButton)
        view.addSubview(pilotButton)
        view.addSubview(exitButton)
    }
    @objc private func onExitButton() {
        presenter.logout()
    }
    private func setElements() {
        NSLayoutConstraint.activate([
            helloLabel.heightAnchor.constraint(equalToConstant: 100),
            helloLabel.widthAnchor.constraint(equalToConstant: 250),
            helloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            helloLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.widthAnchor.constraint(equalToConstant: 200),
            startButton.topAnchor.constraint(equalTo: helloLabel.bottomAnchor, constant: 50),
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shuttleButton.heightAnchor.constraint(equalToConstant: 80),
            shuttleButton.widthAnchor.constraint(equalToConstant: 80),
            shuttleButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 50),
            shuttleButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            recordsButton.heightAnchor.constraint(equalToConstant: 80),
            recordsButton.widthAnchor.constraint(equalToConstant: 80),
            recordsButton.topAnchor.constraint(equalTo: startButton.bottomAnchor, constant: 50),
            recordsButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            settingsButton.heightAnchor.constraint(equalToConstant: 80),
            settingsButton.widthAnchor.constraint(equalToConstant: 80),
            settingsButton.topAnchor.constraint(equalTo: recordsButton.bottomAnchor, constant: 50),
            settingsButton.trailingAnchor.constraint(equalTo: startButton.trailingAnchor),
            infoButton.heightAnchor.constraint(equalToConstant: 80),
            infoButton.widthAnchor.constraint(equalToConstant: 80),
            infoButton.topAnchor.constraint(equalTo: shuttleButton.bottomAnchor, constant: 50),
            infoButton.leadingAnchor.constraint(equalTo: startButton.leadingAnchor),
            pilotButton.heightAnchor.constraint(equalToConstant: 80),
            pilotButton.widthAnchor.constraint(equalToConstant: 80),
            pilotButton.leadingAnchor.constraint(equalTo: infoButton.leadingAnchor),
            pilotButton.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 50),
            exitButton.heightAnchor.constraint(equalToConstant: 80),
            exitButton.widthAnchor.constraint(equalToConstant: 80),
            exitButton.leadingAnchor.constraint(equalTo: pilotButton.trailingAnchor, constant: 50),
            exitButton.topAnchor.constraint(equalTo: infoButton.bottomAnchor, constant: 50)
        ])
    }
}
