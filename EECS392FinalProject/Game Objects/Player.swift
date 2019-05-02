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
    var homework : Int = 0
    var inventory: [Item] = []
    var name : String
    var coffee : Int
    var sleep : Int
    var grade : Double
    
    //TODO: fix this
    /**
    var avgGrade: Int {
        return lowestGradeGiven + inventory.filter { $0 is Textbook}.reduce(0, { max($0, ($1 as! Textbook).gradeBoost) })
    }
 */
    
    init(name: String, homeworkGiven : Int, grade : Double, coffee : Int, sleep : Int) {
        //super.init(name: name, homeworkGiven: homeworkCanDo, avgGradeGiven: avgGradeGiven, extraCredit: extraCredit)
        self.name = name
        self.homework = homeworkGiven
        self.grade = grade
        self.coffee = coffee
        self.sleep = sleep
    }
}
