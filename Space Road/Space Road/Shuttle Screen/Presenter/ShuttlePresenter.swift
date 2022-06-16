//
//  Presenter.swift
//  Space Road
//
//  Created by Kyzu on 15.06.22.
//

import Foundation
protocol ShuttlePresenterDelegate: AnyObject {
    var appCoordinator: AppCoordinator? { get set }
}

class ShuttlePresenter {
    weak var delegate: ShuttlePresenterDelegate?
    
    func back() {
        self.delegate?.appCoordinator?.back()
    }
    
    func saveAndBack(row: Int, imageIndex: Int) {
        var settings = UserDefaultsManager().getSettings()
        settings.indexPathRowForShuttle = row
        settings.shuttleImageIndex = imageIndex
        settings.difficulty = "hard"
        UserDefaultsManager().saveSettings(settings: settings)
        back()
    }
    
    func setViewDelegate(delegate: ShuttlePresenterDelegate) {
        self.delegate = delegate
    }
}
