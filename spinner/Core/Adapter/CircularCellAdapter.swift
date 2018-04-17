//
//  CircularCellAdapter.swift
//  spinner
//
//  Created by Astemir Eleev on 17/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

struct CircularCellAdapter {

    // MARK: - Methods
    
    func configure(cell: CircularCollectionViewCell, forDisplaying comics: Comics) {
        cell.imageName = comics.imageName
    }
}
