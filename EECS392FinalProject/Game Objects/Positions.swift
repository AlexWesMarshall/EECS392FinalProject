//
//  Positions.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/30/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class PointOfInterest: NSObject { //has to be NSObject to use with MKAnnotation ... boo :(
    
    let location: CLLocation
    let name: String
    let isRegenPoint: Bool
    let encounter: Encounter?
    
    init(name: String, location: CLLocation, isRegenPoint: Bool, encounter: Encounter? = nil) {
        self.name = name
        self.location = location
        self.isRegenPoint = isRegenPoint
        self.encounter = encounter
    }
}

extension PointOfInterest {
    //static let AppleStore = PointOfInterest(name: "\"Fruit\" Store", location: CLLocation(latitude: 40.763560, longitude: -73.972321), isRegenPoint: true, encounter: Store.AppleStore)
    static let Balto = PointOfInterest(name: "Balto Statue", location: CLLocation(latitude: 40.7699631, longitude: -73.9732103), isRegenPoint: true)
    static let BoatHouse = PointOfInterest(name: "Entrance to Water Level", location: CLLocation(latitude: 40.7772265, longitude: -73.972275), isRegenPoint: true)
    static let Castle = PointOfInterest(name: "Castle", location: CLLocation(latitude: 40.7794379, longitude: -73.9712102), isRegenPoint: false, encounter: Dean.dean as? Encounter)
    static let Cloisters = PointOfInterest(name: "Monastery", location: CLLocation(latitude: 40.8648668, longitude: -73.9339161), isRegenPoint: false)
    static let Hamilton = PointOfInterest(name: "Warrior's Memorial", location: CLLocation(latitude: 40.7796328, longitude: -73.9676018), isRegenPoint: false)
    static let Met = PointOfInterest(name: "Art Palace", location: CLLocation(latitude: 40.7790478, longitude: -73.96627832), isRegenPoint: false)
    static let Obelisk = PointOfInterest(name: "Obelisk", location: CLLocation(latitude: 40.7796328, longitude: -73.9676018), isRegenPoint: false)
    static let StatueOfLiberty = PointOfInterest(name: "Colossus", location: CLLocation(latitude: 40.6892534, longitude: -74.0466891), isRegenPoint: false)
    static let StrawberryFields = PointOfInterest(name: "Imagine Fields", location: CLLocation(latitude: 40.775556, longitude: -73.975), isRegenPoint: true)
    static let TavernOnGreen = PointOfInterest(name: "Tavern", location: CLLocation(latitude: 40.7721909, longitude: -73.9799102), isRegenPoint: true)
    static let TimesSquare = PointOfInterest(name: "Town", location: CLLocation(latitude: 40.758899, longitude: -73.9873197), isRegenPoint: false)
    static let Zoo = PointOfInterest(name: "Monster Menagerie", location: CLLocation(latitude: 40.767769, longitude: -73.971870), isRegenPoint: false, encounter: Teacher.Ray as? Encounter)
}

extension PointOfInterest: MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D { return location.coordinate }
    var title: String? { return name }
}
