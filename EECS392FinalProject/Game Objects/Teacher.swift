//
//  Teacher.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/30/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Teacher {
    
    let name: String
    var homeworkGiven: Int
    var lowestGradeGiven: Int // assuming that the grade is out of 100 here folks
    var extraCredit: Int
    
    var avgGrade: Int { return lowestGradeGiven }
    
    init(name: String, homeworkGiven: Int, avgGradeGiven: Int, extraCredit: Int = 0) {
        self.name = name
        self.homeworkGiven = homeworkGiven
        self.lowestGradeGiven = avgGradeGiven
        self.extraCredit = extraCredit
    }
}

extension Teacher {
    static let Ray = Teacher(name: "Drew Meyer", homeworkGiven: 3, avgGradeGiven: 30, extraCredit: 10)
}
