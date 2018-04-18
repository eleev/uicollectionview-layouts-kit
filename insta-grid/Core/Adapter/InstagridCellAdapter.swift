//
//  InstagridCellAdapter.swift
//  insta-grid
//
//  Created by Astemir Eleev on 18/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

struct InstagridCellAdapter {
    
    // MARK: - Method
    
    func configure(cell: InstagridCollectionViewCell, forDisplaying comics: Comics) {
        cell.imageName = comics.imageName
    }
    
}
