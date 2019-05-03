//
//  Study.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 5/2/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//
//Study class to specify places for the player to study
//Studying will reduce homework due and sleep/coffee by 1 (That functionality is in Game.swift)

import Foundation

class Study{
    var name : String
    
    init(name : String){
        self.name = name
    }
}

extension Study {
    static let KSL = Study(name: "KSL")
    static let Tink = Study(name: "Tink")
}
