//
//  Dean.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/30/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Dean: Teacher {
    
    let quest: String
    
    init(quest: String, name: String) {
        self.quest = quest
        super.init(name: name, homeworkGiven: 0, avgGradeGiven: 6, extraCredit: 0)
    }
}

extension Dean {
    static let dean = Dean(quest: "Bring me the recommendations of ten teachers, and you'll get your diploma", name: "Dean")
}
