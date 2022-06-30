//
//  GalleryOfShuttleCollectionViewCell.swift
//  Space Road
//
//  Created by Kyzu on 14.06.22.
//

import UIKit

class GalleryOfShuttleCollectionViewCell: UICollectionViewCell {
    
    static let reuseID = "GalleryOfShuttlesCollectionViewCell"
    let currentShuttleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(currentShuttleImageView)
        currentShuttleImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        currentShuttleImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        currentShuttleImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        currentShuttleImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
