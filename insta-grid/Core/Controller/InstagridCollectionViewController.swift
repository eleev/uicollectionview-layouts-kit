//
//  InstagridCollectionViewController.swift
//  insta-grid
//
//  Created by Astemir Eleev on 18/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class InstagridCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    private var adapter = InstagridCellAdapter()
    fileprivate var data: [Comics]?
    let useSquareCells = true

    // MARK: - Outlets
    
    @IBOutlet weak var instagridLayout: InstagridLayout!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        let bundle = Bundle(for: type(of: self))
        let nibName = String(describing: InstagridCollectionViewCell.self)
        let cellNib = UINib(nibName: nibName, bundle: bundle)
        self.collectionView?.register(cellNib, forCellWithReuseIdentifier: InstagridCollectionViewCell.reusableId)
        
        // Do any additional setup after loading the view.
        
        data = ComicsManager.covers()
        
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        // Override the layout delegate if needed
        
        // InstagridLyout setup
        instagridLayout.delegate = self
        instagridLayout.itemSpacing = 10
        instagridLayout.fixedDivisionCount = 4
        instagridLayout.scrollDirection = .vertical
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstagridCollectionViewCell.reusableId, for: indexPath) as? InstagridCollectionViewCell else {
            fatalError(#function + " could not dequeue InstagridCollectionViewCell using the reusable identifier: \(InstagridCollectionViewCell.reusableId)")
        }
    
        // Configure the cell
        guard let comics = data?[indexPath.item] else {
            fatalError(#function + " could not fetch comics from data source using the index path item: \(indexPath.item)")
        }
        adapter.configure(cell: cell, forDisplaying: comics)
        
        return cell
    }

}

extension InstagridCollectionViewController: InstagridLayoutDelegate {
    
    func scaleForItem(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, atIndexPath indexPath: IndexPath) -> UInt {

        
        if indexPath.row % 2 == 0 || indexPath.row % 5 == 0 || indexPath.row % 8 == 0 { return 2 }
        if indexPath.row % 3 == 0 || indexPath.row % 7 == 0 { return 4 }
        return 1
    }

    func itemFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat {
        return useSquareCells ? fixedDimension : 0.8 * fixedDimension
    }

    func headerFlexibleDimension(inCollectionView collectionView: UICollectionView, withLayout layout: UICollectionViewLayout, fixedDimension: CGFloat) -> CGFloat {
        return 0
    }
}
