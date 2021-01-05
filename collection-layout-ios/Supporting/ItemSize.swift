//
//  ItemSize.swift
//  collection-layout-ios
//
//  Created by Astemir Eleev on 21.06.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import UIKit

public enum ItemSize {
    case fixed(CGSize)
    case horizontalAspectFit(spacing: CGFloat, aspect: CGFloat)
    case verticalAspectFit(spacing: CGFloat, aspect: CGFloat)
}

public extension ItemSize {
    func size(in collectionView: UICollectionView) -> CGSize {
        let multiplier: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4.0 : 2.0

        switch self {
        case .fixed(let size):
            return size
        case .horizontalAspectFit(let hspacing, let aspect):
            let spacing = hspacing * UIScreen.main.scale * multiplier
            let width = collectionView.bounds.width - spacing
            
            return CGSize(width: width, height: width / aspect)
        case .verticalAspectFit(let vspacing, let aspect):
            let spacing = vspacing * UIScreen.main.scale * multiplier
            let height = collectionView.bounds.height - spacing
            
            return CGSize(width: height * aspect, height: height)
        }
    }
}
