//
//  Player.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/27/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//
// Player class that stores information for playing the game

import Foundation

class Player {

    var homeworkDue : Int = 0
    var homeworkComplete : Int = 0
    var name : String
    var coffee : Int
    var sleep : Int
    var grade : Double
    var money : Int
    var quest : Quest?
    
    init(name: String, homeworkGiven : Int, grade : Double, coffee : Int, sleep : Int, money : Int) {
        self.name = name
        self.homeworkDue = homeworkGiven
        self.grade = grade
        self.coffee = coffee
        self.sleep = sleep
        self.money = money
    }
}
