//
//  User.swift
//  Space Road
//
//  Created by Kyzu on 11.06.22.
//

import Foundation

struct User: Codable {
    var nick: String?
    var email: String
    var password: String
    var arrayOfRecords: [Int]?
}
