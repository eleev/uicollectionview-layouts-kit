//
//  VerticalSnapCollectionViewController.swift
//  vertical-snap-flow-layout
//
//  Created by Astemir Eleev on 21/05/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

//public extension UICollectionView {
//    
//    /// Registers custom UICollectionViewCell for a UICollectionView instance. UICollectionViewCell needs to be located in current Bundle
//    ///
//    /// Usage example:
//    /// let collectionView = UICollectionView()
//    /// collectionView.register(cellNamed: UICollectionViewCell.self, reuseableIdentifier: "item-cell")
//    ///
//    /// - Parameters:
//    ///   - name: is a name of a UICollectionView that is going to be registered (hint: use UICollectionView.self as a parameter in order to avoid any misspellings)
//    ///   - id: is a reusable identifier for a UICollectionView cell
//    public func register(cellNamed name: UICollectionViewCell.Type, reusableId id: String) {
//        let nibName = String(describing: name)
//        let bundle = Bundle(identifier: nibName)
//        let cellNib = UINib(nibName: nibName, bundle: bundle)
//        self.register(cellNib, forCellWithReuseIdentifier: id)
//    }
//}



class VerticalSnapCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    private var adapter = VerticalSnapCollectionAdapter()
    fileprivate var data: [Comics]?
    
    // MARK: - Outlets
    
    @IBOutlet weak var snapFlowCollectionLayout: VerticalSnapCollectionFlowLayout!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.collectionView?.register(cell: VerticalSnapCollectionViewCell.self, reusableId: VerticalSnapCollectionViewCell.reusableId)
        
        // Do any additional setup after loading the view.
        
        data = ComicsManager.covers()

        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets.init(top: 24, left: 16, bottom: 24, right: 16)        
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalSnapCollectionViewCell.reusableId, for: indexPath) as? VerticalSnapCollectionViewCell else {
            fatalError(#function + " could not dequeue VerticalSnapCollectionViewCell using the reusable identifier: \(VerticalSnapCollectionViewCell.reusableId)")
        }
        
        // Configure the cell
        guard let comics = data?[indexPath.item] else {
            fatalError(#function + " could not fetch comics from data source using the index path item: \(indexPath.item)")
        }
        adapter.configure(cell: cell, forDisplaying: comics)
        
        return cell
    }

}
