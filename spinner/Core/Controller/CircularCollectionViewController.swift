//
//  CircularCollectionViewController.swift
//  spinner
//
//  Created by Astemir Eleev on 17/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

let reusableId = "cell"

class CircularCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    private var adapter = CircularCellAdapter()
    fileprivate var data: [Comics]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: CircularCollectionViewCell.self)
        let cellNib = UINib(nibName: nibName, bundle: bundle)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: CircularCollectionViewCell.reusableId)

        // Do any additional setup after loading the view.
        
        data = ComicsManager.covers()
        
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        // Override the layout delegate if needed
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableId, for: indexPath) as? CircularCollectionViewCell else {
            fatalError(#function + " could not dequeue CircularCollectionViewCell using the reusable identifier: \(CircularCollectionViewCell.reusableId)")
        }
        // Configure the cell
        guard let comics = data?[indexPath.item] else {
            fatalError(#function + " could not fetch comics from data source using the index path item: \(indexPath.item)")
        }
        adapter.configure(cell: cell, forDisplaying: comics)
        
        return cell
    }

}
