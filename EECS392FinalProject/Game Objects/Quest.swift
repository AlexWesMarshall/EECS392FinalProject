//
//  Quest.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 5/2/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//
//Details where a quest can be started, where the quest ends,
//a description of the quest, and a description when the quest is completed
//To complete a quest, players must walk from the startLocation to the endLocation (functionality in MapViewController)

import Foundation

class Quest{
    var description : String
    var startLocation : PointOfInterest
    var endLocation : PointOfInterest
    var reward : Int
    var completedDescription : String
    
    init(description : String, startLocation : PointOfInterest, endLocation : PointOfInterest, reward : Int, completedDescription : String){
        self.description = description
        self.startLocation = startLocation
        self.endLocation = endLocation
        self.reward = reward
        self.completedDescription = completedDescription
    }
}

extension Quest {
    static let wadeQuest = Quest(description: "Meet your friends at Fribley for dinner", startLocation: .WadeQ, endLocation: .FribleyQ, reward: 5, completedDescription: "Your friends aren't here 🙃 but at least you found $5 on the ground.")
}
