//
//  CoordinatorProtocol.swift
//  Space Road
//
//  Created by Kyzu on 9.06.22.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController { get set}
    func start()
}
