//
//  ShuttleViewController.swift
//  Space Road
//
//  Created by Kyzu on 14.06.22.
//

import UIKit

class ShuttleViewController: UIViewController, Storyboarded {

    private var labelSelect: UILabel!
    private var homeButton: UIButton!
    private var galleryOfShuttles = GalleryOfShuttlesCollectionView()
    weak var appCoordinator: AppCoordinator?
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "shuttleScreen")!)
        view = customView
        setLabelSelect()
        view.addSubview(galleryOfShuttles)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        setElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        galleryOfShuttles.scrollToItem(at: [0, 5], at: .centeredHorizontally, animated: true)
        galleryOfShuttles.layoutIfNeeded()
    }
    
    private func setLabelSelect() {
        labelSelect = UILabel.infoLabel(text: "labelSelect.text".localizable(), size: 38, lines: 2)
        view.addSubview(labelSelect)
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
            galleryOfShuttles.heightAnchor.constraint(equalToConstant: 150)
            ])
    }
}
