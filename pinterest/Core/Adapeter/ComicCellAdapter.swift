//
//  ComicCellAdapter.swift
//  pinterest
//
//  Created by Astemir Eleev on 16/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation
import UIKit

/// Decouples View from Model layer by presenting the intermediate layer called Adapter. Current struct adaps comics data for comics cell without tightly coupling the two. 
struct ComicsCellAdapter {
    
    // MARK: - Methods
    
    func configure(cell: ComicsCell, forDisplaying comics: Comics) {
        cell.coverImage.image = comics.image
        cell.captionLabel.text = comics.caption
        cell.commentLabel.text = comics.comment
    }
    
}
