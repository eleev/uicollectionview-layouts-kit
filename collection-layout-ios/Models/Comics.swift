//
//  Comics.swift
//  pinterest-collection-flow-layout-ios
//
//  Created by Astemir Eleev on 16/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import UIKit

struct Comics {
    
    // MARK: - Properties
    
    var image: UIImage
    var imageName: String
    var caption: String
    var comment: String
    
    // MARK: - Initializers
    
    init(image: UIImage, imageName: String, caption: String, comment: String) {
        self.image = image
        self.caption = caption
        self.comment = comment
        self.imageName = imageName
    }
    
    init?(dictionary: [String : String]) {
        guard let image = dictionary["Cover"], let cover = UIImage(named: image), let caption = dictionary["Caption"], let comment = dictionary["Comment"] else {
            debugPrint(#function + " one of the data properties from ComicData.plist could not be unwrapped or is nil")
            return nil
        }
        self.init(image: cover, imageName: image, caption: caption, comment: comment)
    }
    
   
    
}
