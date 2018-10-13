//
//  ComicCell.swift
//  pinterest
//
//  Created by Astemir Eleev on 16/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class ComicsCell: UICollectionViewCell {

    // MARK: - Statics
    
    static let reusalbeId = "comics-cell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    // MARK: - Overrides
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        
        captionLabel.sizeToFit()
        commentLabel.sizeToFit()
    }
        
}
