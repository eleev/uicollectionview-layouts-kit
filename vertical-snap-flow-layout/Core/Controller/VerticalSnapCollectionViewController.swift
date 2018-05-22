//
//  VerticalSnapCollectionViewController.swift
//  vertical-snap-flow-layout
//
//  Created by Astemir Eleev on 21/05/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

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

        // Register cell classes // Register cell classes
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: VerticalSnapCollectionViewCell.self)
        let cellNib = UINib(nibName: nibName, bundle: bundle)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: VerticalSnapCollectionViewCell.reusableId)

        // Do any additional setup after loading the view.
        
        data = ComicsManager.covers()

        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsetsMake(24, 16, 24, 16)        
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Configure the cell
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VerticalSnapCollectionViewCell.reusableId, for: indexPath) as? VerticalSnapCollectionViewCell else {
            fatalError(#function + " could not dequeue InstagridCollectionViewCell using the reusable identifier: \(VerticalSnapCollectionViewCell.reusableId)")
        }
        
        // Configure the cell
        guard let comics = data?[indexPath.item] else {
            fatalError(#function + " could not fetch comics from data source using the index path item: \(indexPath.item)")
        }
        adapter.configure(cell: cell, forDisplaying: comics)
        
        return cell
    }

}
