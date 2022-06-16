//
//  UIImageView+customUIV.swift
//  Space Road
//
//  Created by Kyzu on 16.06.22.
//

import Foundation
import UIKit

extension UIImageView {
    
    static func conformImage(originalImage: String, size: CGSize) -> UIImageView {
        let image = UIImage(named: originalImage)
        
        let scaledImageSize = size
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let scaledImage = renderer.image { _ in
            image!.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }
        let imView = UIImageView(image: scaledImage)
        return imView
    }
}
