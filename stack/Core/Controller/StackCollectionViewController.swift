//
//  StackCollectionViewController.swift
//  stack
//
//  Created by Astemir Eleev on 21.06.2020.
//  Copyright © 2020 Astemir Eleev. All rights reserved.
//

import UIKit

class StackCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let adapter = SafariCellAdapter()
    fileprivate var data: [Comics]?
    
    // MARK: - Outlets

    @IBOutlet weak var stackLayout: StackCollectionViewLayout!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SafariPageCell.self, forCellWithReuseIdentifier: SafariPageCell.reuseIdentifier)
        data = ComicsManager.covers()
        
        let layout = StackCollectionViewLayout()
//        layout.itemHeight = 500
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .black
    }
}

extension StackCollectionViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SafariPageCell.reuseIdentifier, for: indexPath) as? SafariPageCell else {
            fatalError("Could not cast a UICollectionViewCell to SafaripageCell type")
        }
        guard let comics = data?[indexPath.item] else {
            fatalError("Could not fetch comics from data source using the index path item: \(indexPath.item)")
        }
        adapter.configure(cell: cell, forDisplaying: comics)
        
        return cell
    }
}
