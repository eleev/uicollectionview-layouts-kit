//
//  SafariCellAdapter.swift
//  safari-iphone
//
//  Created by Astemir Eleev on 30/06/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import UIKit

struct SafariCellAdapter {
    
    // MARK: - Methods
    
    func configure(cell: SafariPageCell, forDisplaying comics: Comics) {
        cell.image = comics.image
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.imageContentMode = .scaleAspectFill
        cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
//        cell.layer.borderColor = UIColor.white.cgColor
//        cell.layer.borderWidth = 10
        
    }
}
