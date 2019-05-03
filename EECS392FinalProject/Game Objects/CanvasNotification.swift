//
//  CanvasNotification.swift
//  EECS392FinalProject
//
//  Created by Alexander Marshall on 5/2/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//
//CanvasNotification class to add more homework to complete to the player

import Foundation

class CanvasNotification {
    var homework : Int
    
    init(homework : Int){
        self.homework = homework
    }
}

extension CanvasNotification {
    static let PBLNotification = CanvasNotification(homework: 2)
}
