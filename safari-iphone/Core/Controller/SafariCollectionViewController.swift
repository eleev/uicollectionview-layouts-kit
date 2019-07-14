//
//  SafariCollectionViewController.swift
//  safari-iphone
//
//  Created by Astemir Eleev on 30/06/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit

class SafariCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private let adapter = SafariCellAdapter()
    fileprivate var data: [Comics]?
    
    // MARK: - Outlets

    @IBOutlet weak var safariIPhoneLayout: SafariIPhoneCollectionViewLayout!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(SafariPageCell.self, forCellWithReuseIdentifier: SafariPageCell.reuseIdentifier)
        data = ComicsManager.covers()
        
        let layout = SafariIPhoneCollectionViewLayout()
        layout.itemHeight = 500
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.backgroundColor = .black
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension SafariCollectionViewController {

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
