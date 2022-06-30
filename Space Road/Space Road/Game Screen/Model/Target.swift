//
//  Target.swift
//  Space Road
//
//  Created by Kyzu on 16.06.22.
//

import Foundation
import UIKit

class Target: UIImageView {
   
    var movingAnimation = UIViewPropertyAnimator()
    
    let skinsForTarget = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    var currentSkin: String {
        let skinNum = Int.random(in: 0...skinsForTarget.count-1)
        return skinsForTarget[skinNum]
    }

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFit
        self.image = UIImage(named: currentSkin)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movingTarget(direction: CGFloat) {
        movingAnimation.startAnimation()
    }
    
    static func generateTargets(targetSize: CGSize, targetPoints: [CGPoint]) -> [Target] {
        let points = targetPoints.shuffled().suffix(Int.random(in: 1...2))
        var targets: [Target] = []
        
        for point in points {
            targets.append(Target.init(frame: CGRect(x: point.x, y: point.y, width: targetSize.width - 4, height: targetSize.height)))
        }
        return targets
    }
    
}
