//
//  ResultView.swift
//  Space Road
//
//  Created by Kyzu on 19.06.22.
//

import Foundation
import UIKit

class ResultView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var newRecordLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupContentView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setupContentView() {
        Bundle.main.loadNibNamed(String(describing: ResultView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        translatesAutoresizingMaskIntoConstraints = false
        homeButton.titleLabel?.isEnabled = false
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
