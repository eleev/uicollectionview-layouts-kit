//
//  VerticalSnapCollectionViewCell.swift
//  vertical-snap-flow-layout
//
//  Created by Astemir Eleev on 22/05/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class VerticalSnapCollectionViewCell: UICollectionViewCell {

    // MARK: - Static properties
    
    static let reusableId = "image-cell"
    
    // MARK: - Properties
    
    var imageName: String = "" {
        didSet {
            imageView.image = UIImage(named: imageName)
        }
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepare()
    }
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageView.contentMode = .scaleAspectFit
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func prepareForReuse() {
        contentView.backgroundColor = .black
        imageView.image = nil
    }

    // MARK: - Helpers
    
    private func prepare() {
        
        contentView.layer.cornerRadius = 15.0
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.borderWidth = 5.0
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.clipsToBounds = true
    }
}
