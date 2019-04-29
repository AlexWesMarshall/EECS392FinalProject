//
//  Teachers.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/25/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Teacher {
    
    // MARK: - Properties
    let name: String
    var numAs: Int
    var baseHomeworkHours: Int
    var extraCredit: Int
    
    var strength: Int { return baseHomeworkHours }
    
    // MARK: - Initializers
    init(name: String, numAs: Int, homeworkHours: Int, extraCredit: Int = 0) {
        self.name = name
        self.numAs = numAs
        self.baseHomeworkHours = homeworkHours
        self.extraCredit = extraCredit
    }
}

extension Teacher {
    static let DrewMeyer = Teacher(name: "Drew Meyer", numAs: 1, homeworkHours: 1, extraCredit: 10)
}
