//
//  String+Localizable.swift
//  Space Road
//
//  Created by Kyzu on 6.06.22.
//

import UIKit

extension String {
    func localizable() -> String {
        NSLocalizedString(self, comment: "")
    }
}
