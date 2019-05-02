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
    func encounteredDean(dean: Dean)
    func canvasNotification(canvasNotification : CanvasNotification)
}

class Game {
    
    static let shared = Game()
    var player: Player?
    var pointsOfInterest: [PointOfInterest] = []
    var lastPOI: PointOfInterest?
    //var warps: [WarpZone] = []
    //var reservoir: [CLLocationCoordinate2D] = []
    
    weak var delegate: GameDelegate?
    
    init() {
        player = Player(name: "Frankum", homeworkGiven: 0, grade: 85, coffee: 2, sleep: 2)
        setupPOIs()
        //setupWarps()
        //setupResevoir()
    }
    
    private func setupPOIs() {
        pointsOfInterest = [.Sears, .KSL, .Tink, .Veale, .EuclidStarbucks, .PBL, .Village]
    }
    
    /*private func setupWarps() {
        warps = [WarpZone(latitude: 40.765158, longitude: -73.974774, color: UIColor.yellow),
                 WarpZone(latitude: 40.768712, longitude: -73.981590, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.768712, longitude: -73.981590, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.776219, longitude: -73.976247, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.776219, longitude: -73.976247, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.781987, longitude: -73.972020, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.781987, longitude: -73.972020, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.785253, longitude: -73.969638, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.785253, longitude: -73.969638, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.791605, longitude: -73.964853, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.791605, longitude: -73.964853, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.796089, longitude: -73.961463, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.796089, longitude: -73.961463, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.799988, longitude: -73.958480, color: #colorLiteral(red: 1, green: 0.3882352941, blue: 0.09803921569, alpha: 1)),
                 WarpZone(latitude: 40.799988, longitude: -73.958480, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.798493, longitude: -73.952622, color: #colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1)),
                 WarpZone(latitude: 40.755238, longitude: -73.987405, color: #colorLiteral(red: 0.7254901961, green: 0.2, blue: 0.6784313725, alpha: 1)),
                 WarpZone(latitude: 40.754344, longitude: -73.987105, color: #colorLiteral(red: 0.9882352941, green: 0.8, blue: 0.03921568627, alpha: 1)),
                 WarpZone(latitude: 40.865757, longitude: -73.927088, color: #colorLiteral(red: 0, green: 0.2235294118, blue: 0.6509803922, alpha: 1)),
                 WarpZone(latitude: 40.701789, longitude: -74.013004, color: #colorLiteral(red: 0.9333333333, green: 0.2078431373, blue: 0.1803921569, alpha: 1))
        ]
    } */
    /**
    private func setupResevoir() {
        reservoir = [
            CLLocationCoordinate2D(latitude: 40.78884, longitude: -73.95857),
            CLLocationCoordinate2D(latitude: 40.78889, longitude: -73.95824),
            CLLocationCoordinate2D(latitude: 40.78882, longitude: -73.95786),
            CLLocationCoordinate2D(latitude: 40.78867, longitude: -73.95758),
            CLLocationCoordinate2D(latitude: 40.78838, longitude: -73.95749),
            CLLocationCoordinate2D(latitude: 40.78793, longitude: -73.95764),
            CLLocationCoordinate2D(latitude: 40.78744, longitude: -73.95777),
            CLLocationCoordinate2D(latitude: 40.78699, longitude: -73.95777),
            CLLocationCoordinate2D(latitude: 40.78655, longitude: -73.95779),
            CLLocationCoordinate2D(latitude: 40.78609, longitude: -73.95818),
            CLLocationCoordinate2D(latitude: 40.78543, longitude: -73.95867),
            CLLocationCoordinate2D(latitude: 40.78469, longitude: -73.95919),
            CLLocationCoordinate2D(latitude: 40.78388, longitude: -73.95975),
            CLLocationCoordinate2D(latitude: 40.78325, longitude: -73.96022),
            CLLocationCoordinate2D(latitude: 40.78258, longitude: -73.96067),
            CLLocationCoordinate2D(latitude: 40.78227, longitude: -73.96101),
            CLLocationCoordinate2D(latitude: 40.78208, longitude: -73.96136),
            CLLocationCoordinate2D(latitude: 40.782, longitude: -73.96172),
            CLLocationCoordinate2D(latitude: 40.78201, longitude: -73.96202),
            CLLocationCoordinate2D(latitude: 40.78214, longitude: -73.96247),
            CLLocationCoordinate2D(latitude: 40.78237, longitude: -73.96279),
            CLLocationCoordinate2D(latitude: 40.78266, longitude: -73.96309),
            CLLocationCoordinate2D(latitude: 40.7832, longitude: -73.96331),
            CLLocationCoordinate2D(latitude: 40.78361, longitude: -73.96363),
            CLLocationCoordinate2D(latitude: 40.78382, longitude: -73.96395),
            CLLocationCoordinate2D(latitude: 40.78401, longitude: -73.96453),
            CLLocationCoordinate2D(latitude: 40.78416, longitude: -73.96498),
            CLLocationCoordinate2D(latitude: 40.78437, longitude: -73.9656),
            CLLocationCoordinate2D(latitude: 40.78456, longitude: -73.96601),
            CLLocationCoordinate2D(latitude: 40.78479, longitude: -73.96636),
            CLLocationCoordinate2D(latitude: 40.78502, longitude: -73.96661),
            CLLocationCoordinate2D(latitude: 40.78569, longitude: -73.96659),
            CLLocationCoordinate2D(latitude: 40.78634, longitude: -73.9664),
            CLLocationCoordinate2D(latitude: 40.78705, longitude: -73.96623),
            CLLocationCoordinate2D(latitude: 40.78762, longitude: -73.96603),
            CLLocationCoordinate2D(latitude: 40.78791, longitude: -73.96571),
            CLLocationCoordinate2D(latitude: 40.78816, longitude: -73.96533),
            CLLocationCoordinate2D(latitude: 40.78822, longitude: -73.9649),
            CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96445),
            CLLocationCoordinate2D(latitude: 40.78819, longitude: -73.96404),
            CLLocationCoordinate2D(latitude: 40.78814, longitude: -73.96378),
            CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96354),
            CLLocationCoordinate2D(latitude: 40.78819, longitude: -73.96327),
            CLLocationCoordinate2D(latitude: 40.78817, longitude: -73.96301),
            CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96269),
            CLLocationCoordinate2D(latitude: 40.7882, longitude: -73.96245),
            CLLocationCoordinate2D(latitude: 40.7883, longitude: -73.96217),
            CLLocationCoordinate2D(latitude: 40.7885, longitude: -73.96189),
            CLLocationCoordinate2D(latitude: 40.78874, longitude: -73.96161),
            CLLocationCoordinate2D(latitude: 40.78884, longitude: -73.96127),
            CLLocationCoordinate2D(latitude: 40.78885, longitude: -73.96093),
            CLLocationCoordinate2D(latitude: 40.78879, longitude: -73.9606),
            CLLocationCoordinate2D(latitude: 40.78869, longitude: -73.96037),
            CLLocationCoordinate2D(latitude: 40.78864, longitude: -73.96009),
            CLLocationCoordinate2D(latitude: 40.78863, longitude: -73.95972),
            CLLocationCoordinate2D(latitude: 40.78863, longitude: -73.95936),
            CLLocationCoordinate2D(latitude: 40.78867, longitude: -73.95895)
        ]
    }
 */
    
    func visitedLocation(location: CLLocation) {
        guard let currentPOI = poiAtLocation(location: location) else { return }
        
        if currentPOI.isRegenPoint {
            regenAdventurer()
        }
        
        switch currentPOI.encounter {
        case let dean as Dean:
            delegate?.encounteredDean(dean: dean)
        case let teacher as Teacher:
            delegate?.encounteredTeacher(teacher: teacher)
        case let canvasNotification as CanvasNotification:
            delegate?.canvasNotification(canvasNotification: canvasNotification)
        /*case let store as Store:
            delegate?.enteredStore(store: store) */
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
        
        //give the player a fighting chance to bring up their grade
        //teacher.lowestGradeGiven -= player.lowestGradeGiven
        if teacher.lowestGradeGiven <= 0 {
            //player.extraCredit += teacher.extraCredit
            return .PlayerWon
        }
        
        //player.homeworkGiven -= teacher.avgGrade
        /**
        if player.homeworkGiven > player.maxHomeworkCanDo {
            player.isDefeated = true
            return .PlayerLost
        }
        */
        return .Tie
    }
    
    func purchaseItem(item: Item) -> ItemResult? {
        guard let player = player else { return nil }
        
        defer { NotificationCenter.default.post(name: GameStateNotification, object: self) }
        /**
        if player.extraCredit >= item.cost {
            player.extraCredit -= item.cost
            player.inventory.append(item)
            return .Purchased
        } else {
            return .NotEnoughExtraCredit
        }
        */
        return .NotEnoughExtraCredit
    }
}

extension Game {
    
    func image(for teacher: Teacher) -> UIImage? {
        switch teacher.name {
        case Teacher.Ray.name:
            return UIImage(named: "Teacher")
        case Dean.dean.name:
            return UIImage(named: "Dean")
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
