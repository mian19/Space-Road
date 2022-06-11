//
//  Storyboarded.swift
//  Space Road
//
//  Created by Kyzu on 9.06.22.
// swiftlint:disable force_cast

import Foundation
import UIKit

protocol Storyboarded {
    static func createObject() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as! Self
        return viewController
    }
}
