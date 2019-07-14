//
//  SafariIPhoneCollectionViewLayout.swift
//  safari-iphone
//
//  Created by Astemir Eleev on 30/06/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit

class SafariIPhoneCollectionViewLayout: UICollectionViewLayout {

    // MARK: - Properties
    
    public var itemGap: CGFloat = 150
    public var itemHeight: CGFloat = 300
    public var itemAngleOfRotation: CGFloat = -45
    public lazy var bottomItemPadding: CGFloat = {
        return contentSize.height / 6
    }()
    
    private var attributes = [UICollectionViewLayoutAttributes]()
    private var contentSize: CGSize = .init(width: 0, height: 0)
    
    // MARK: - Overrides
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override public var collectionViewContentSize: CGSize {
        return self.contentSize
    }
    
    override public func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView, collectionView.numberOfSections == 1, attributes.isEmpty else { return }
        
        var top = CGFloat(0.0)
        let left = CGFloat(0.0)
        let width = collectionView.frame.size.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        contentSize = CGSize(width: width, height: itemHeight + collectionView.contentInset.top + collectionView.contentInset.bottom)
        
        let count = collectionView.numberOfItems(inSection: 0)
        
        for item in 0..<count {
            let indexPath = IndexPath(item: item, section: 0)
            let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            let frame = CGRect(x: left, y: top, width: width, height: itemHeight)
            
            attribute.frame = frame
            attribute.zIndex = item
            
            var angleOfRotation = itemAngleOfRotation
            
            var frameOffset = CGFloat(Float(collectionView.contentOffset.y - frame.origin.y) - floorf(Float(collectionView.frame.size.height / 45.0)))
            
            var xScale = attribute.transform3D.m11
            var yScale = attribute.transform3D.m22
            let minOffset: CGFloat = 45
            
            if frameOffset > 0 {
                frameOffset = frameOffset / 5.0
                frameOffset = min(frameOffset, minOffset)

                angleOfRotation += frameOffset
                let scaleOffset = frameOffset / itemHeight

                xScale -= scaleOffset
                yScale -= scaleOffset
            } else {
                frameOffset = frameOffset / 25.0
                frameOffset = min(frameOffset, minOffset)
                angleOfRotation += CGFloat(frameOffset)
            }
            
            let gap = itemGap
            attribute.transform3D = makePerspectiveTranslation(outOf: angleOfRotation, using: .init(x: xScale, y: yScale))
            attributes.append(attribute)
            
            top += gap
        }
        
        if attributes.count > 0, let lastItemAttributes = attributes.last {
            let newHeight = lastItemAttributes.frame.origin.y + lastItemAttributes.frame.size.height + bottomItemPadding + collectionView.contentInset.top + collectionView.contentInset.bottom
            let newWidth = collectionView.frame.size.width - (collectionView.contentInset.left + collectionView.contentInset.right)

            contentSize = CGSize(width: newWidth, height: newHeight)
        }
    }
    
    override public func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes[itemIndexPath.item]
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in attributes where attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
        return attributes[indexPath.item]
    }
    
    
    override func invalidateLayout() {
        super.invalidateLayout()
        attributes = []
    }
    
    // MARK: - Private utility
    
    private func makePerspectiveTranslation(outOf angleOfRotation: CGFloat, using scale: CGPoint) -> CATransform3D {
        let rotation = CATransform3DMakeRotation((CGFloat.pi * angleOfRotation / 180.0), 1.0, 0.0, 0.0)
        let depth = CGFloat(300.0)
        
        let translateDown = CATransform3DMakeTranslation(0.0, -itemHeight / 5, -depth)
        let translateUp = CATransform3DMakeTranslation(0.0, 0.0, depth)
        var scaleTransform = CATransform3DIdentity
        scaleTransform.m34 = -1.0 / 1300.0
        scaleTransform.m11 = scale.x
        scaleTransform.m22 = scale.y
        
        let perspective = CATransform3DConcat(CATransform3DConcat(translateDown, scaleTransform), translateUp)
        let transform = CATransform3DConcat(rotation, perspective)
        return transform
    }
    
}
