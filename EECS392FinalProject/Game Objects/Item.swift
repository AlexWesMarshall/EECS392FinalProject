//
//  Item.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/29/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Item {
    
    // MARK: - Properties
    let name: String
    let cost: Int
    
    // MARK: - Initializers
    init(name: String, cost: Int) {
        self.cost = cost
        self.name = name
    }
}
