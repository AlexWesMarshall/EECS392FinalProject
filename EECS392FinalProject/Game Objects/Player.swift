//
//  Player.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/27/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Player: Teacher {

    var isDefeated = false
    var maxHomeworkCanDo: Int = 0
    var inventory: [Item] = []
    
    //TODO: fix this
    override var avgGrade: Int {
        return lowestGradeGiven + inventory.filter { $0 is Textbook}.reduce(0, { max($0, ($1 as! Textbook).gradeBoost) })
    }
    
    override init(name: String, homeworkGiven homeworkCanDo: Int, avgGradeGiven: Int, extraCredit: Int = 1) {
        super.init(name: name, homeworkGiven: homeworkCanDo, avgGradeGiven: avgGradeGiven, extraCredit: extraCredit)
        
        maxHomeworkCanDo = homeworkGiven
    }
}
