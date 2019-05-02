//
//  Player.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/27/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Player {

    var isDefeated = false
    var homeworkDue : Int = 0
    var homeworkComplete : Int = 0
    var inventory: [Item] = []
    var name : String
    var coffee : Int
    var sleep : Int
    var grade : Double
    var money : Int
    
    init(name: String, homeworkGiven : Int, grade : Double, coffee : Int, sleep : Int, money : Int) {
        self.name = name
        self.homeworkDue = homeworkGiven
        self.grade = grade
        self.coffee = coffee
        self.sleep = sleep
        self.money = money
    }
}
