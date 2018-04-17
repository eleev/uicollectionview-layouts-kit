//
//  CircularCollectionViewLayoutAttributes.swift
//  spinner
//
//  Created by Astemir Eleev on 17/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    // MARK: - Properties
    
    // Overrides the anchor point becase the rotation happens around a point that isn't the center
    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    // Internally sets the transform to be equal to a rotation of angle radians. The right cells also need to overlap the ones to their left, so setting zIndex to a function that increases in angle should give such effect.
    var angle: CGFloat = 0.0 {
        didSet {
            zIndex = Int(angle * 1000000)
            transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    // MARK: - Overrides
    
    override func copy(with zone: NSZone? = nil) -> Any {
        // This method needs to override current method since the attributes can be copied internally when the collection view is perfoming layout. The override guarantees that both the anchor point and angle properties are set when the obser is copied.
        
        let copiedAttribues: CircularCollectionViewLayoutAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttribues.anchorPoint = self.anchorPoint
        copiedAttribues.angle = self.angle
        return copiedAttribues
    }
}
