//
//  RecordsPresenter.swift
//  Space Road
//
//  Created by Kyzu on 28.06.22.
//

import Foundation
import UIKit

protocol RecordsPresenterDelegate: AnyObject {
    var appCoordinator: AppCoordinator? { get set }
    var recordsTable: UITableView! { get set }
    var userRecord: Int! { get set }
    var records: [(key: String, value: Int)]! { get set }
}

class RecordsPresenter {
    weak var delegate: RecordsPresenterDelegate?
 
    func downloadUserRecord() {
        FireBaseManager().getUserRecord(completion: {record in
            print(record)
            DispatchQueue.main.async {
                self.delegate?.userRecord = record
                self.delegate?.recordsTable.reloadData()
            }
        })
    }
    
    func downloadWorldRecords() {
        FireBaseManager().getWorldRecords(completion: {wrecords in
            DispatchQueue.main.async {
                self.delegate?.records = wrecords.sorted { $0.value > $1.value}
                self.delegate?.recordsTable.reloadData()
            }
        })
    }
    
    func setViewDelegate(delegate: RecordsPresenterDelegate) {
        self.delegate = delegate
    }
}
