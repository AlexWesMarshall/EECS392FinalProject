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

enum FightResult {
    case PlayerWon, PlayerLost, Tie
}

enum ItemResult {
    case Purchased, NotEnoughExtraCredit
}

let GameStateNotification = Notification.Name("GameUpdated")

protocol GameDelegate: class {
    func encounteredTeacher(teacher: Teacher)
    func canvasNotification(canvasNotification : CanvasNotification)
    func studyEncounter(study : Study)
    func coffeeEncounter(coffeeShop : Starbucks, title : String?)
    func turnInHomework()
}

class Game {
    
    static let shared = Game()
    var player: Player?
    var pointsOfInterest: [PointOfInterest] = []
    var lastPOI: PointOfInterest?
    
    weak var delegate: GameDelegate?
    
    init() {
        player = Player(name: "Frankum", homeworkGiven: 0, grade: 85, coffee: 1, sleep: 3, money : 0)
        setupPOIs()
    }
    
    private func setupPOIs() {
        pointsOfInterest = [.Sears, .KSL, .Tink, .Veale, .EuclidStarbucks, .PBL, .Village]
    }
    
    func visitedLocation(location: CLLocation) {
        guard let currentPOI = poiAtLocation(location: location) else { return }
        if currentPOI.isRegenPoint {
            regenAdventurer()
        }
        switch currentPOI.encounter {
        case let teacher as Teacher:
            delegate?.encounteredTeacher(teacher: teacher)
        case let canvasNotification as CanvasNotification:
            delegate?.canvasNotification(canvasNotification: canvasNotification)
        case let study as Study:
            delegate?.studyEncounter(study : study)
        case let coffeeShop as Starbucks:
            delegate?.coffeeEncounter(coffeeShop: coffeeShop, title : nil)
        case _ as Homework:
            delegate?.turnInHomework()
        default:
            break
        }
    }
    
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
    
    func regenAdventurer() {
        guard let player = player else { return }
        player.sleep = 3
        player.isDefeated = false
    }
    
    func fight(teacher: Teacher) -> FightResult? {
        guard let player = player else { return nil }
        defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }
        if teacher.lowestGradeGiven <= 0 {
            return .PlayerWon
        }
        return .Tie
    }
    
    func purchaseItem(item: Item) -> ItemResult? {
        guard let player = player else { return nil }
        defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }
        return .NotEnoughExtraCredit
    }
}

extension Game {
    
    func image(for teacher: Teacher) -> UIImage? {
        switch teacher.name {
        case Teacher.Ray.name:
            return UIImage(named: "Teacher")
        default:
            return nil
        }
    }
    
    func image(for item: Item) -> UIImage? {
        switch item.name {
        case Textbook.aiTextbook.name:
            return UIImage(named: "Textbook")
        default:
            return nil
        }
    }
}
