//
//  Textbook.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/30/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Textbook : Item {
    
    let gradeBoost: Int
    
    init(name: String, cost: Int, gradeBoost: Int) {
        self.gradeBoost = gradeBoost
        super.init(name: name, cost: cost)
    }
}

extension Textbook {
    static let aiTextbook = Textbook(name: "AI Textbook", cost: 50, gradeBoost: 6)
}
