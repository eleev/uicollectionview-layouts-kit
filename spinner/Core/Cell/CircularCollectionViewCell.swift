//
//  CircularCollectionViewCell.swift
//  spinner
//
//  Created by Astemir Eleev on 17/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Static properties
    
    static let reusableId = "cell"
    
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
        imageView.contentMode = .scaleAspectFit
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        // Since anchor point is a custom propertiy, it needs to be manually applied here, in subclass. 
        
        guard let circularLayoutAttributes = layoutAttributes as? CircularCollectionViewLayoutAttributes else {
            debugPrint(#function + " could not case UICollectionViewLayoutAttribures to CircularCollectionViewLayoutAttribures, the execution of the method will be aborted")
            return
        }
        self.layer.anchorPoint = circularLayoutAttributes.anchorPoint
        self.center.y += (circularLayoutAttributes.anchorPoint.y - 0.5) * self.bounds.height
        
    }
    
    // MARK: - Helpers
    
    private func prepare() {
        
        contentView.layer.cornerRadius = 5.0
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.clipsToBounds = true
        
    }
    
}
