//
//  Game.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/30/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import UIKit
import CoreLocation

let ENCOUNTER_RADIUS: CLLocationDistance = 10 //meters

let GameStateNotification = Notification.Name("GameUpdated")

//GameDelegate for running encounters in MapViewController
protocol GameDelegate: class {
    func canvasNotification(canvasNotification : CanvasNotification)
    func studyEncounter(study : Study)
    func coffeeEncounter(coffeeShop : Starbucks, title : String?)
    func turnInHomework()
    func startQuest(quest : Quest)
    func endQuest(quest : Quest)
}

class Game {
    
    static let shared = Game() //Shared instance of the game to keep track of the player
    var player: Player?
    var pointsOfInterest: [PointOfInterest] = []
    var lastPOI: PointOfInterest?
    
    weak var delegate: GameDelegate?
    
    init() {
        player = Player(name: "Frankum", homeworkGiven: 0, grade: 85.00, coffee: 1, sleep: 3, money : 0)
        setupPOIs()
    }
    
    //Add the names of the POIs in Positions
    private func setupPOIs() {
        pointsOfInterest = [.Sears, .KSL, .Tink, .Veale, .EuclidStarbucks, .PBL, .Village, .Wade, .Fribley]
    }
    
    //Checks if the current location is an encounter location
    //Switch statement determines the specific type of encounter
    func visitedLocation(location: CLLocation) {
        guard let currentPOI = poiAtLocation(location: location) else { return }
        
        switch currentPOI.encounter {
        case let canvasNotification as CanvasNotification:
            delegate?.canvasNotification(canvasNotification: canvasNotification)
        case let study as Study:
            delegate?.studyEncounter(study : study)
        case let coffeeShop as Starbucks:
            delegate?.coffeeEncounter(coffeeShop: coffeeShop, title : nil)
        case _ as Homework:
            delegate?.turnInHomework()
        case let quest as Quest:
            //If the current location is close to a quest start CLLocation
            if(currentPOI.location.distance(from: quest.startLocation.location) < 0.001){
                delegate?.startQuest(quest : quest)
            }
            //Else if the current location is close to a quest end CLLocation
            else if(currentPOI.location.distance(from: quest.endLocation.location) < 0.005){
                delegate?.endQuest(quest : quest)
            }
        default:
            break
        }
    }
    
    //Turns the current location into a PointOfInterest
    func poiAtLocation(location: CLLocation) -> PointOfInterest? {
        for point in pointsOfInterest {
            let center = point.location
            let distance = abs(location.distance(from: center))
            if distance < ENCOUNTER_RADIUS {
                //debounce staying in the same spot for awhile
                if point != lastPOI {
                    lastPOI = point
                    return point
                } else {
                    return nil
                }
            }
        }
        lastPOI = nil
        return nil
    }
}
