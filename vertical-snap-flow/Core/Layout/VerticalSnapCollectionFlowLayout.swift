//
//  SnapCollectionFlowLayout.swift
//  snap-flow-layout
//
//  Created by Astemir Eleev on 21/05/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class VerticalSnapCollectionFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Properties
    
    private var firstSetupDone = false
    
    var spacingMultiplier: CGFloat = 6 {
        didSet {
            invalidateLayout()
        }
    }
    
    var minLineSpacing: CGFloat = 20 {
        didSet {
            minimumLineSpacing = minLineSpacing
            invalidateLayout()
        }
    }
    var itemHeight: CGFloat = 0 {
        didSet {
            recalculateItemSize(for: itemHeight)
        }
    }
    
    // MARK: - Overrides
    
    override func prepare() {
        super.prepare()
        
        if !firstSetupDone {
            setup()
            firstSetupDone = true
        }
        
        guard let unwrappedCollectionView = collectionView else {
            return
        }
        let height = unwrappedCollectionView.frame.height
        recalculateItemSize(for: height)
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        
        let layoutAttributes = layoutAttributesForElements(in: collectionView!.bounds)
        
        let centerOffset = collectionView!.bounds.size.height / 2
        let offsetWithCenter = proposedContentOffset.y + centerOffset
        
        guard let unwrappedLayoutAttributes = layoutAttributes else {
            return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        }
        
        let closestAttribute = unwrappedLayoutAttributes
            .sorted { abs($0.center.y - offsetWithCenter) < abs($1.center.y - offsetWithCenter) }
            .first ?? UICollectionViewLayoutAttributes()
        
        return CGPoint(x: 0, y: closestAttribute.center.y - centerOffset)
    }
  
    
    // MARK: - Private helpers
    
    private func setup() {
        guard let unwrappedCollectionView = collectionView else {
            return
        }
        scrollDirection = .vertical
        minimumLineSpacing = minLineSpacing
        itemSize = CGSize(width: unwrappedCollectionView.bounds.width, height: itemHeight)
        collectionView!.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    private func recalculateItemSize(for itemHeight: CGFloat) {
        guard let unwrappedCollectionView = collectionView else {
            return
        }
        let horizontalContentInset = unwrappedCollectionView.contentInset.left + unwrappedCollectionView.contentInset.right
        let verticalContentInset = unwrappedCollectionView.contentInset.bottom + unwrappedCollectionView.contentInset.top
    
        var divider: CGFloat = 1.0
        
        if unwrappedCollectionView.bounds.width > unwrappedCollectionView.bounds.height {
            // collection view bounds are in landscape so we change the item width in a way where 2 rows can be displayed
            divider = 2.0
        }
        
        itemSize = CGSize(width: unwrappedCollectionView.bounds.width / divider - horizontalContentInset, height: itemHeight - (minLineSpacing * spacingMultiplier) - verticalContentInset)
        
        invalidateLayout()
    }
}
