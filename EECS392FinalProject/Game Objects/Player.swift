//
//  Player.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/27/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Player: Teacher {
    
    // MARK: - Properties
    var isDefeated = false
    var maxNumA: Int = 0
    var inventory: [Item] = []
    
    override var strength: Int {
        return baseHomeworkHours + inventory.filter { $0 is Weapon}.reduce(0, { max($0, ($1 as! Weapon).strength) })
    }
    
    // MARK: - Initializers
    override init(name: String, numAs: Int, homeworkHours: Int, extraCredit: Int = 100) {
        super.init(name: name, numAs: numAs, homeworkHours: homeworkHours, extraCredit: extraCredit)
        
        maxNumA = numAs
    }
}
