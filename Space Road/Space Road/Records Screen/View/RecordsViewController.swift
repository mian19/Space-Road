//
//  RecordsViewController.swift
//  Space Road
//
//  Created by Kyzu on 28.06.22.
//

import UIKit

class RecordsViewController: UIViewController, Storyboarded {

    private var titleLabel: UILabel!
    private var homeButton: UIButton!
    private var recordsSegmentControl: UISegmentedControl!
    weak var appCoordinator: AppCoordinator?
    var typeRecords = ["my.records".localizable(), "world.records".localizable()]
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "recordsScreen")!)
        view = customView
        setButton()
        setTitle()
        setRecordsSegmentControl()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
    }
    
    private func setTitle() {
        titleLabel = UILabel.infoLabel(text: "recordsLabel.text".localizable(), size: 38, lines: 1)
        
        view.addSubview(titleLabel)
    }
    
    private func setRecordsSegmentControl() {
        recordsSegmentControl = UISegmentedControl(items: typeRecords)
        recordsSegmentControl.translatesAutoresizingMaskIntoConstraints = false
        let font = UIFont.systemFont(ofSize: 16)
        recordsSegmentControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        recordsSegmentControl.backgroundColor = .gray
        recordsSegmentControl.selectedSegmentIndex = 0
        view.addSubview(recordsSegmentControl)
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
            recordsSegmentControl.widthAnchor.constraint(equalToConstant: 180),
            recordsSegmentControl.heightAnchor.constraint(equalToConstant: 40),
            recordsSegmentControl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            recordsSegmentControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 20),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}
