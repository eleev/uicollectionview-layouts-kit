//
//  CircularLayout.swift
//  spinner
//
//  Created by Astemir Eleev on 17/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

protocol CircularLayoutDelegate: class {
    func collectionView(_ collectionView:UICollectionView, widthForItemAtIndexPath indexPath:IndexPath) -> CGFloat
}

class CircularLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    
    weak var delegate: CircularLayoutDelegate!
    
    let itemSize = CGSize(width: 500.0, height: 700.0) // 133, 173
    
    var radius: CGFloat = 1700 { // 500
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem: CGFloat {
        return atan(itemSize.width / radius)
    }
    
    var angleAtExtreme: CGFloat {
        guard let collectionView = collectionView else {
            debugPrint(#function + " could not unwrap collection view, the calculated value fot the property will be set to 0.0")
            return 0.0
        }
        let numberOfItemsInZeroSection = collectionView.numberOfItems(inSection: 0)
        return numberOfItemsInZeroSection > 0 ? -CGFloat(numberOfItemsInZeroSection - 1) * anglePerItem : 0
    }
    
    var angle: CGFloat {
        guard let collectionView = collectionView else {
            debugPrint(#function + " could not unwrap collection view, the calculated value fot the property will be set to 0.0")
            return 0.0
        }
        return angleAtExtreme * collectionView.contentOffset.x / (collectionViewContentSize.width - collectionView.bounds.width)
    }
    
    var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    // MARKK: - Overrides
    
    override static var layoutAttributesClass: AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else {
            fatalError(#function + " could not unwrap collectionView instnace - it is nil")
        }
        let numberOfItemsInZeroSection = CGFloat(collectionView.numberOfItems(inSection: 0))
        let width = CGFloat(numberOfItemsInZeroSection * itemSize.width)
        let height = CGFloat(collectionView.bounds.height)
        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else {
            debugPrint(#function + " could not unwrap collection view because it is nil")
            return
        }
        
        let centerX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let anchorPointY = ((itemSize.height / 2.0) + radius) / itemSize.height
        let padding: CGFloat = 8
        
        let boundsWidth = collectionView.bounds.width
        let boundsHeight = collectionView.bounds.height
        let itemsInSectionZero = collectionView.numberOfItems(inSection: 0)
        let theta = atan2(boundsWidth / 2.0, radius + (itemSize.height / 2.0) - (boundsHeight / 2.0))

        var startIndex = 0
        var endIndex = itemsInSectionZero - 1

        // If the angular position of the 0th item is less than -theta, then it lies outside the screen. In that case, the first item on the screen will be the difference between -θ and angle divided by anglePerItem;
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle) / anglePerItem))
        }
        // Similarly, the last element on the screen will be the difference between θ and angle divided by anglePerItem, and min serves as an additional check to ensure endIndex doesn’t go beyond the total number of items;
        endIndex = min(endIndex, Int(ceil((theta - angle) / anglePerItem)))

        // Lastly, you add a safety check to make the range 0...0 if endIndex is less than startIndex. This edge case occurs when you scroll with a very high velocity and all the cells go completely off-screen.
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
        
        attributesList = (startIndex...endIndex).map({ index -> CircularCollectionViewLayoutAttributes in
            let indexPath = IndexPath(item: index, section: 0)
            
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: indexPath)
            let size = CGSize(width: padding * 2 + self.itemSize.width, height: self.itemSize.height)
            attributes.size = size
            
            // Position each item at the center of the screen
            attributes.center = CGPoint(x: centerX, y: collectionView.bounds.midY)
            // Rotate each item at an angle per item times positional index
            attributes.angle = self.angle + (self.anglePerItem * CGFloat(index))
            // Override the defualt anchor point
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)

            return attributes
        })
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesList[indexPath.row]
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        // Returning true from this method tells the collection view to invalidate it’s layout as it scrolls, which in turn calls prepare() where you can recalculate the cells’ layout with updated angular positions.
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        guard let collectionView = collectionView else {
            fatalError(#function + " could not unwrap collection view since it is nil")
        }
        
        // Adds suport for snapping behaviour. For for the main implementation of circular layout it is not important and has no direct relation. Feel free to remove this method.
        
        var finalContentOffset = proposedContentOffset
        let factor = -angleAtExtreme / (collectionViewContentSize.width - collectionView.bounds.width)
        let proposedAngle = proposedContentOffset.x * factor
        let ratio = proposedAngle/anglePerItem
        var multiplier: CGFloat
        
        if (velocity.x > 0) {
            multiplier = ceil(ratio)
        } else if (velocity.x < 0) {
            multiplier = floor(ratio)
        } else {
            multiplier = round(ratio)
        }
        
        finalContentOffset.x = multiplier * anglePerItem / factor
        return finalContentOffset
    }
    
}
