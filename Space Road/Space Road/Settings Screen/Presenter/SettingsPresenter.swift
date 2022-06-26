//
//  SettingsPresenter.swift
//  Space Road
//
//  Created by Kyzu on 26.06.22.
//

import Foundation

protocol SettingsPresenterDelegate: AnyObject {
    var appCoordinator: AppCoordinator? { get set}
}

class SettingsPresenter {
    weak var delegate: SettingsPresenterDelegate?
    
    func saveSettings(diff: Int?, sound: Int?) {
        var settings = UserDefaultsManager().getSettings()
        settings.difficulty = diff ?? settings.difficulty
        settings.sounds = sound ?? settings.sounds
        UserDefaultsManager().saveSettings(settings: settings)
        delegate?.appCoordinator?.back()
    }
    
    func setViewDelegate(delegate: SettingsPresenterDelegate) {
        self.delegate = delegate
    }
}
