//
//  Homework.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 5/2/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//
//Class to specify where players can turn in homework
//Homework is indistinguishable, but that is just another property to add here

import Foundation

class Homework{
    var location : String
    
    init(location : String){
        self.location = location
    }
}

extension Homework{
    static let Sears = Homework(location : "Sears")
}
