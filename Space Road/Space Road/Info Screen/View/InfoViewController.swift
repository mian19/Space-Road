//
//  InfoViewController.swift
//  Space Road
//
//  Created by Kyzu on 27.06.22.
//

import UIKit

class InfoViewController: UIViewController, Storyboarded {
    
    private var textView: UITextView!
    private var homeButton: UIButton!
    private var tgButton: UIButton!
    private var linkButton: UIButton!
    weak var appCoordinator: AppCoordinator?
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        setBackground()
        setButtons()
        setTextView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setElements()
        
    }
    
    private func setBackground() {
        let imageView = UIImageView(image: UIImage(named: "infoScreen"))
        imageView.frame = view.frame
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
    }
    
    private func setTextView() {
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(hex: "000099")
        textView.text = "info.text".localizable()
        textView.textAlignment = .center
        textView.adjustsFontForContentSizeCategory = true
        textView.layer.cornerRadius = 10
        textView.isScrollEnabled = false
        textView.clipsToBounds = true
        textView.font = UIFont(name: "Play-Regular", size: 22)
        textView.textColor = .white
        
        view.addSubview(textView)
    }
    
    private func setButtons() {
        homeButton = UIButton.systemButton(image: "home")
        homeButton.addTarget(self, action: #selector(onHomeButton), for: .touchUpInside)
        tgButton = UIButton.systemButton(image: "tg")
        tgButton.addTarget(self, action: #selector(onTgButton), for: .touchUpInside)
        linkButton = UIButton.systemButton(image: "link")
        linkButton.addTarget(self, action: #selector(onLinkButton), for: .touchUpInside)
        view.addSubview(homeButton)
        view.addSubview(tgButton)
        view.addSubview(linkButton)
    }
    
    @objc func onHomeButton() {
        appCoordinator?.back()
    }
    
    @objc func onTgButton() {
        openApp(app: "tg")
    }
    
    @objc func onLinkButton() {
        openApp(app: "link")
    }
    
    private func openApp(app: String) {
        var link1: String!
        var link2: String!
        if app == "tg" {
            link1 = "tg://resolve?domain=mian19"
            link2 = "https://t.me/mian19"
        } else {
            link1 = "linkedin://resolve?domain=mian19"
            link2 = "https://www.linkedin.com/in/mian19/"
        }
        let appURL = URL(string: link1)!
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL) {
            application.open(appURL)
        } else {
            // if app is not installed, open URL inside Safari
            let webURL = URL(string: link2)!
            application.open(webURL)
        }
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
            textView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textView.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            textView.heightAnchor.constraint(equalToConstant: 220),
            textView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            tgButton.heightAnchor.constraint(equalToConstant: 80),
            tgButton.widthAnchor.constraint(equalToConstant: 80),
            tgButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10),
            tgButton.trailingAnchor.constraint(equalTo: textView.centerXAnchor, constant: -20),
            linkButton.heightAnchor.constraint(equalToConstant: 80),
            linkButton.widthAnchor.constraint(equalToConstant: 80),
            linkButton.topAnchor.constraint(equalTo: tgButton.topAnchor),
            linkButton.leadingAnchor.constraint(equalTo: textView.centerXAnchor, constant: 20),
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 20),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
