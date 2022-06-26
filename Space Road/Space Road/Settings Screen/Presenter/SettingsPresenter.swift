//
//  SettingsPresenter.swift
//  Space Road
//
//  Created by Kyzu on 26.06.22.
//

import Foundation

protocol SettingsPresenterDelegate: AnyObject {
    
}

class SettingsPresenter {
    weak var delegate: SettingsPresenterDelegate?
    
    func setViewDelegate(delegate: SettingsPresenterDelegate) {
        self.delegate = delegate
    }
}
