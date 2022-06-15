//
//  ShuttleViewController.swift
//  Space Road
//
//  Created by Kyzu on 14.06.22.
//

import UIKit

class ShuttleViewController: UIViewController, Storyboarded, ShuttlePresenterDelegate {

    private var labelSelect: UILabel!
    private var homeButton: UIButton!
    private var selectButton: UIButton!
    private var changeColorButton: UIButton!
    private var galleryOfShuttles = GalleryOfShuttlesCollectionView()
    private let presenter = ShuttlePresenter()
    weak var appCoordinator: AppCoordinator?
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "shuttleScreen")!)
        view = customView
        view.addSubview(galleryOfShuttles)
        setLabelSelect()
        setButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        presenter.setViewDelegate(delegate: self)
        setElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        galleryOfShuttles.scrollToItem(at: [0, UserDefaultsManager().getSettings().indexPathRowForShuttle], at: .centeredHorizontally, animated: true)
        galleryOfShuttles.cellForItem(at: [0, UserDefaultsManager().getSettings().indexPathRowForShuttle])?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        galleryOfShuttles.layoutIfNeeded()
    }
    
    private func setLabelSelect() {
        labelSelect = UILabel.infoLabel(text: "labelSelect.text".localizable(), size: 38, lines: 2)
        view.addSubview(labelSelect)
    }
    
    private func setButtons() {
        selectButton = UIButton.withTextButton(with: "selectButton.text".localizable(), size: 15)
        selectButton.addTarget(self, action: #selector(onSelectButton), for: .touchUpInside)
        changeColorButton = UIButton.withTextButton(with: "changeColorButton.text".localizable(), size: 15)
        changeColorButton.addTarget(self, action: #selector(onChangeColorButton), for: .touchUpInside)
        homeButton = UIButton.systemButton(image: "home")
        homeButton.addTarget(self, action: #selector(onHomeButton), for: .touchUpInside)
        view.addSubview(selectButton)
        view.addSubview(changeColorButton)
        view.addSubview(homeButton)
    }
    
    @objc func onSelectButton() {
        presenter.saveAndBack(row: galleryOfShuttles.selectedIndexPath.row, imageIndex: galleryOfShuttles.shuttleColorIndex)
    }
    
    @objc func onChangeColorButton() {
        if !galleryOfShuttles.isDragging {
            galleryOfShuttles.changeShuttleColor()
        }
    }
    
    @objc func onHomeButton() {
        presenter.back()
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
            labelSelect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            labelSelect.widthAnchor.constraint(equalToConstant: 280),
            labelSelect.heightAnchor.constraint(equalToConstant: 150),
            labelSelect.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            galleryOfShuttles.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            galleryOfShuttles.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            galleryOfShuttles.widthAnchor.constraint(equalTo: view.widthAnchor),
            galleryOfShuttles.heightAnchor.constraint(equalToConstant: 150),
            selectButton.topAnchor.constraint(equalTo: galleryOfShuttles.bottomAnchor, constant: 10),
            selectButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            selectButton.widthAnchor.constraint(equalToConstant: 100),
            selectButton.heightAnchor.constraint(equalToConstant: 40),
            
            changeColorButton.topAnchor.constraint(equalTo: galleryOfShuttles.bottomAnchor, constant: 10),
            changeColorButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            changeColorButton.widthAnchor.constraint(equalToConstant: 100),
            changeColorButton.heightAnchor.constraint(equalToConstant: 40),
            
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 30),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
}
