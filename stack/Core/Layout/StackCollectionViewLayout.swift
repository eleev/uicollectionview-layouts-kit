//
//  StackCollectionViewLayout.swift
//  stack
//
//  Created by Astemir Eleev on 21.06.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import UIKit

open class StackCollectionViewLayout: UICollectionViewLayout {
    
    // MARK: - Properties
    
//    public var itemDescription: (landscape: StackItemSize, portrait: StackItemSize) =
//        (landscape: StackItemSize.fixed(.init(width: 150, height: 224.999999999999888)),
//         portrait: StackItemSize.fixed(.init(width: 200, height: 300))) { // 0,666666666666667 aspect ratio
////        .init(width: 300, height: 449.999999999999775)
//        didSet {
//            invalidateLayout()
//        }
//    }
    
    public var itemDescription: (landscape: ItemSize, portrait: ItemSize) =
        (landscape: .verticalAspectFit(spacing: 24, aspect: 0.666666666666667),
         portrait: .horizontalAspectFit(spacing: 24, aspect: 0.666666666666667)) { // 0,666666666666667 aspect ratio
        didSet {
            invalidateLayout()
        }
    }
    
    public var spacing: CGFloat = 12 {
        didSet{
            invalidateLayout()
        }
    }
    
    public var maximumVisibleItems: Int = 5 {
        didSet{
            invalidateLayout()
        }
    }
    
    public var isPagingEnabled: Bool = true {
        didSet {
            collectionView.isPagingEnabled = isPagingEnabled
        }
    }
    
    // MARK: Overrides
    
    override open var collectionView: UICollectionView {
        return super.collectionView!
    }
    
    override open var collectionViewContentSize: CGSize {
        let itemsCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        return CGSize(width: collectionView.bounds.width * itemsCount,
                      height: collectionView.bounds.height)
    }
    
    override open func prepare() {
        super.prepare()
        assert(collectionView.numberOfSections == 1, "Please note that multiple sections are not supported")
        collectionView.isPagingEnabled = isPagingEnabled
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let totalItemsCount = collectionView.numberOfItems(inSection: 0)
        
        let minVisibleIndex = max(Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width), 0)
        let maxVisibleIndex = min(minVisibleIndex + maximumVisibleItems, totalItemsCount)
        
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        
        var attributes = [UICollectionViewLayoutAttributes]()

        for index in minVisibleIndex...maxVisibleIndex {
            let indexPath = IndexPath(item: index, section: 0)

            let cellAttribute = computeLayoutAttributesForItem(indexPath: indexPath,
                                                               minVisibleIndex: minVisibleIndex,
                                                               contentCenterX: contentCenterX,
                                                               deltaOffset: CGFloat(deltaOffset),
                                                               percentageDeltaOffset: percentageDeltaOffset)
            attributes += [cellAttribute]
        }
    
        return attributes
    }
    
    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let contentCenterX = collectionView.contentOffset.x + (collectionView.bounds.width / 2.0)
        let minVisibleIndex = Int(collectionView.contentOffset.x) / Int(collectionView.bounds.width)
        let deltaOffset = Int(collectionView.contentOffset.x) % Int(collectionView.bounds.width)
        let percentageDeltaOffset = CGFloat(deltaOffset) / collectionView.bounds.width
        return computeLayoutAttributesForItem(indexPath: indexPath,
                                              minVisibleIndex: minVisibleIndex,
                                              contentCenterX: contentCenterX,
                                              deltaOffset: CGFloat(deltaOffset),
                                              percentageDeltaOffset: percentageDeltaOffset)
    }
    
    // MARK: - Private Helpers
    
    private func scale(at index: Int) -> CGFloat {
        let translatedCoefficient = CGFloat(index) - CGFloat(self.maximumVisibleItems) / 2
        return CGFloat(pow(0.95, translatedCoefficient))
    }
    
    private func transform(atCurrentVisibleIndex visibleIndex: Int, percentageOffset: CGFloat) -> CGAffineTransform {
        var rawScale = visibleIndex < maximumVisibleItems ? scale(at: visibleIndex) : 1.0
        
        if visibleIndex != 0 {
            let previousScale = scale(at: visibleIndex - 1)
            let delta = (previousScale - rawScale) * percentageOffset
            rawScale += delta
        }
        return CGAffineTransform(scaleX: rawScale, y: rawScale)
    }
    
    fileprivate func computeLayoutAttributesForItem(indexPath: IndexPath,
                                                    minVisibleIndex: Int,
                                                    contentCenterX: CGFloat,
                                                    deltaOffset: CGFloat,
                                                    percentageDeltaOffset: CGFloat) -> UICollectionViewLayoutAttributes {
        let attributes = UICollectionViewLayoutAttributes(forCellWith:indexPath)
        let visibleIndex = indexPath.row - minVisibleIndex

        let bounds = UIScreen.main.bounds
        if bounds.width > bounds.height {
            attributes.size = itemDescription.landscape.size(in: collectionView)
        } else {
            attributes.size = itemDescription.portrait.size(in: collectionView)
        }
        
        let midY = self.collectionView.bounds.midY
        attributes.center = CGPoint(x: contentCenterX + spacing * CGFloat(visibleIndex),
                                    y: midY + spacing * CGFloat(visibleIndex))
        attributes.zIndex = maximumVisibleItems - visibleIndex
        
        attributes.transform = transform(atCurrentVisibleIndex: visibleIndex,
                                         percentageOffset: percentageDeltaOffset)
        switch visibleIndex {
        case 0:
            attributes.center.x -= deltaOffset
            break
        case 1..<maximumVisibleItems:
            attributes.center.x -= spacing * percentageDeltaOffset
            attributes.center.y -= spacing * percentageDeltaOffset
            
            if visibleIndex == maximumVisibleItems - 1 {
                attributes.alpha = percentageDeltaOffset
            }
            break
        default:
            attributes.alpha = 0
            break
        }
        return attributes
    }
}
