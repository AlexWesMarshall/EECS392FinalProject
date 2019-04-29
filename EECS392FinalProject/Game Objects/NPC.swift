//
//  NPC.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/27/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class NPC: Monster {
    
    // MARK: - Properties
    let quest: String
    
    // MARK: - Initializers
    init(quest: String, name: String) {
        self.quest = quest
        super.init(name: name, hitPoints: 0, strength: 0)
    }
}

extension NPC {
    static let King = NPC(quest: "Bring me the ears of ten goblins, and you'll get a great reward", name: "King")
}
