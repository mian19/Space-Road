//
//  Game.swift
//  Space Road
//
//  Created by Kyzu on 16.06.22.
//

import Foundation

protocol GameProtocol {
    var currentScore: Int { get set }
    var gameSpeed: TimeInterval {get}
    func increaseSpeed()
    
}

class Game: GameProtocol {
    var currentScore: Int = 0
    var gameSpeed: TimeInterval = {
        var difficult = UserDefaultsManager().getSettings().difficulty
        var timeInterval: TimeInterval!
        switch difficult {
        case 0:
            timeInterval = 2
        case 1:
            timeInterval = 1.75
        case 2:
            timeInterval = 1.5
        default:
            return 0
        }
        return timeInterval
    }()
    
    func increaseSpeed() {
        
        if currentScore > 0 && currentScore % 23 == 0 && gameSpeed >= 1.2 {
            gameSpeed -= 0.1
        }
    }

}
