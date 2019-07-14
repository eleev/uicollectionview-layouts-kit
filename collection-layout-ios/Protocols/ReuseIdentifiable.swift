//
//  ReuseIdentifiable.swift
//  safari-iphone
//
//  Created by Astemir Eleev on 30/06/2019.
//  Copyright © 2019 Astemir Eleev. All rights reserved.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
