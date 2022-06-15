//
//  Settings.swift
//  Space Road
//
//  Created by Kyzu on 14.06.22.
//

import Foundation

struct Settings: Codable {
    var shuttleImageIndex: Int = 1
    var indexPathRowForShuttle = 0
    var difficulty: String = "easy"
    var backgroundMusic: Bool = true
    var sounds: Bool = true
}
