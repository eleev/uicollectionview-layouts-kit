//
//  ComicManager.swift
//  collection-flow-layout-ios
//
//  Created by Astemir Eleev on 16/04/2018.
//  Copyright © 2018 Astemir Eleev. All rights reserved.
//

import Foundation

struct ComicsManager {
    
    // MARK: - Properties
    
    static let dataSource = "ComicsData"
    static let type = "plist"
    
    // MARK: - Methods
    
    static func covers() -> [Comics] {
        var covers = [Comics]()
        
        guard let url = Bundle.main.url(forResource: dataSource, withExtension: type), let coverDict = NSArray(contentsOf: url) as? [[String : String]] else {
            
            debugPrint(#function + " could not find Comics asset catalog or something went wrong" )
            return covers
        }
        
        for dictPair in coverDict {
            if let comicCover = Comics(dictionary: dictPair) {
                covers += [comicCover]
            }
        }
        
        return covers
    }
}
