//
//  LevelSegmentedControl.swift
//  Space Road
//
//  Created by Kyzu on 26.06.22.
//

import UIKit

class LevelSegmentedControl: UISegmentedControl {
      
    static func levelControl() -> LevelSegmentedControl {
        var levelControl = LevelSegmentedControl(items: difficulties)
    }
        
}
