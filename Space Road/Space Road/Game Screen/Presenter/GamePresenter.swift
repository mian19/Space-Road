//
//  GamePresenter.swift
//  Space Road
//
//  Created by Kyzu on 16.06.22.
//

import Foundation

protocol GamePresenterDelegate: AnyObject {
}

class GamePresenter {
    weak var delegate: GamePresenterDelegate?
    var isPause = false
    
    func setViewDelegate(delegate: GamePresenterDelegate) {
        self.delegate = delegate
    }
}
