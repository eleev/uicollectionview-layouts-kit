//
//  UICollectionView+CustomCellRegistration.swift
//  ios-collection-view-layouts
//
//  Created by Astemir Eleev on 31/05/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    /// Registers custom UICollectionViewCell for a UICollectionView instance. UICollectionViewCell needs to be located in current Bundle
    ///
    /// Usage example:
    /// let collectionView = UICollectionView()
    /// collectionView.register(cellNamed: UICollectionViewCell.self, reuseableIdentifier: "item-cell")
    ///
    /// - Parameters:
    ///   - name: is a name of a UICollectionView that is going to be registered (hint: use UICollectionView.self as a parameter in order to avoid any misspellings)
    ///   - id: is a reusable identifier for a UICollectionView cell
    public func register(cell name: UICollectionViewCell.Type, reusableId id: String) {
        let nibName = String(describing: name)
        let bundle = Bundle(identifier: nibName)
        let cellNib = UINib(nibName: nibName, bundle: bundle)
        self.register(cellNib, forCellWithReuseIdentifier: id)
    }
}

