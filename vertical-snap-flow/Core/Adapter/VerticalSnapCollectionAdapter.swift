//
//  VerticalSnapCollectionAdapter.swift
//  vertical-snap-flow-layout
//
//  Created by Astemir Eleev on 22/05/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

struct VerticalSnapCollectionAdapter {
    
    // MARK: - Methods
    
    func configure(cell: VerticalSnapCollectionViewCell, forDisplaying comics: Comics) {
        cell.imageName = comics.imageName
    }
}
