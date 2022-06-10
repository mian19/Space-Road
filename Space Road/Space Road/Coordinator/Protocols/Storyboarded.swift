//
//  Storyboarded.swift
//  Space Road
//
//  Created by Kyzu on 9.06.22.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func createObject() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func createObject() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: id, bundle: .main)
        // swiftlint:disable force_cast
        let vc = storyboard.instantiateInitialViewController() as! Self
        return vc
    }
}
