//
//  Study.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 5/2/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation

class Study : Encounter{
    var name : String
    
    init(name : String){
        self.name = name
    }
}

extension Study {
    static let KSL = Study(name: "KSL")
    static let Tink = Study(name: "Tink")
}
