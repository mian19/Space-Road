//
//  Presenter.swift
//  Space Road
//
//  Created by Kyzu on 13.06.22.
//

import Foundation

protocol MainPresenterDelegate: AnyObject {
    
}

class MainPresenter {
    weak var delegate: MainPresenterDelegate?
}
