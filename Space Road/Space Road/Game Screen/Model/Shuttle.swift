//
//  Shuttle.swift
//  Space Road
//
//  Created by Kyzu on 16.06.22.
//

import Foundation
import UIKit

class Shuttle: UIImageView {
    var movingAnimation = UIViewPropertyAnimator()
    var currentSkin: String {
        let settings = UserDefaultsManager().getSettings()
        let str = "\(settings.indexPathRowForShuttle+1)_\(settings.shuttleImageIndex)"
        return str
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentMode = .scaleAspectFit
        self.image = UIImage(named: currentSkin)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movingShuttle(direction: CGFloat) {
        let step = self.frame.width
        movingAnimation = UIViewPropertyAnimator(duration: 0.05, curve: .linear, animations: {self.frame.origin.x += direction * step})
        movingAnimation.startAnimation()
    }
}
