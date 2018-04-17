//
//  ComicsCollectionViewController.swift
//  pinterest
//
//  Created by Astemir Eleev on 16/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class ComicsCollectionViewController: UICollectionViewController {

    // MARK: - Properties
    
    private var adapter = ComicsCellAdapter()
    fileprivate var data: [Comics]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
        data = ComicsManager.covers()
        
        collectionView?.backgroundColor = .clear
        collectionView?.contentInset = UIEdgeInsets(top: 24, left: 16, bottom: 24, right: 16)
        
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return data?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicsCell.reusalbeId, for: indexPath) as? ComicsCell else {
            fatalError(#function + " could not unwrap a ComicsCell using reusable identifier: \(ComicsCell.reusalbeId)")
        }
        // Configure the cell
        guard let comics = data?[indexPath.item] else {
            fatalError(#function + " could not fetch comics for index path: \(indexPath.item)")
        }
        adapter.configure(cell: cell, forDisplaying: comics)
        
        return cell
    }
}

// MARK: - Extension that adds conformance to UICollectionViewDelegateFlowLayout
extension ComicsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let contentInset = collectionView.contentInset
        let itemSize = (collectionView.frame.width - (contentInset.left + contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}

// MARK: - Extension that adds suport for PinterestLayoutDelegate protocol
extension ComicsCollectionViewController: PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        guard let comics = data?[indexPath.item] else {
            fatalError(#function + " could not retreive comics at index path : \(indexPath.item)")
        }
        return comics.image.size.height
    }
}
