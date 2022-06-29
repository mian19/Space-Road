//
//  RecordsViewController.swift
//  Space Road
//
//  Created by Kyzu on 28.06.22.
//

import UIKit

class RecordsViewController: UIViewController, Storyboarded, RecordsPresenterDelegate {

    private var titleLabel: UILabel!
    private var homeButton: UIButton!
    private var recordsSegmentControl: UISegmentedControl!
    var recordsTable: UITableView!
    private let presenter = RecordsPresenter()
    weak var appCoordinator: AppCoordinator?
    var typeRecords = ["my.records".localizable(), "world.records".localizable()]
    var userRecord: Int!
    var selectedRecord = 0
    var records: [(key: String, value: Int)]!
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(patternImage: UIImage(named: "recordsScreen")!)
        view = customView
        setButton()
        setTitle()
        setRecordsSegmentControl()
        setRecordsTable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.downloadUserRecord()
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
        recordsSegmentControl.addTarget(self, action: #selector(onRecordsSegmentControl), for: .valueChanged)
        view.addSubview(recordsSegmentControl)
    }
    
    @objc func onRecordsSegmentControl(target: UISegmentedControl) {
        if target.selectedSegmentIndex == 0 {
            selectedRecord = 0
            getUserRecord()
        } else {
            selectedRecord = 1
            getWorldRecords()
        }
    }
    
    private func setRecordsTable() {
        recordsTable = UITableView()
        recordsTable.translatesAutoresizingMaskIntoConstraints = false
        recordsTable.delegate = self
        recordsTable.dataSource = self
        recordsTable.backgroundColor = .clear
        recordsTable.register(UINib(nibName: "RecordCellTableViewCell", bundle: nil), forCellReuseIdentifier: "record")
        view.addSubview(recordsTable)
    }
    
    private func setButton() {
        homeButton = UIButton.systemButton(image: "home")
        homeButton.addTarget(self, action: #selector(onHomeButton), for: .touchUpInside)
        view.addSubview(homeButton)
    }
    
    func getUserRecord() {
        presenter.downloadUserRecord()
    }
    
    func getWorldRecords() {
        presenter.downloadWorldRecords()
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
            recordsTable.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9),
            recordsTable.topAnchor.constraint(equalTo: recordsSegmentControl.bottomAnchor, constant: 10),
            recordsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordsTable.bottomAnchor.constraint(equalTo: homeButton.topAnchor, constant: -20),
            homeButton.heightAnchor.constraint(equalToConstant: 80),
            homeButton.widthAnchor.constraint(equalToConstant: 80),
            view.bottomAnchor.constraint(equalTo: homeButton.bottomAnchor, constant: 20),
            homeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

extension RecordsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedRecord == 0 {
            return 1
        } else {
            return records.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "record", for: indexPath) as? RecordCellTableViewCell else {
            return UITableViewCell()
        }
        cell.queueLabel.text = "\(indexPath.row + 1)"
        if selectedRecord == 0 {
            cell.nickLabel.text = "\(KeychainManager().get()?.nick ?? "")"
            cell.recordLabel.text = "\(self.userRecord ?? 0)"
        } else {
            cell.nickLabel.text = records[indexPath.row].key
            cell.recordLabel.text = "\(records[indexPath.row].value)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
}
