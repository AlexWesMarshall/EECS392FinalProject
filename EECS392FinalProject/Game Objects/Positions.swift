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
    let encounter: Encounter?
    
    init(name: String, location: CLLocation, encounter: Encounter? = nil) {
        self.name = name
        self.location = location
        self.encounter = encounter
    }
}

extension PointOfInterest {
    static let Sears = PointOfInterest(name: "Sears", location : CLLocation(latitude: 41.502789, longitude: -81.608062), encounter : Homework.Sears)
    static let KSL = PointOfInterest(name: "Lib Lab", location : CLLocation(latitude: 41.507266, longitude: -81.609636), encounter : Study.KSL)
    static let Tink = PointOfInterest(name: "University Center", location : CLLocation(latitude: 41.508165, longitude: -81.608554), encounter : Study.Tink)
    static let Veale = PointOfInterest(name: "Gym", location : CLLocation(latitude: 41.500997, longitude: -81.606147))
    static let EuclidStarbucks = PointOfInterest(name: "\"Energy\" Store", location : CLLocation(latitude: 41.508156, longitude: -81.605971), encounter : Starbucks.EuclidStarbucks)
    static let PBL = PointOfInterest(name: "Business Center", location : CLLocation(latitude: 41.509816, longitude: -81.607754), encounter : CanvasNotification.PBLNotification)
    static let Village = PointOfInterest(name: "Village", location : CLLocation(latitude: 41.512195, longitude: -81.603606))
    static let WadeQ = PointOfInterest(name: "Wade Quest Start", location : CLLocation(latitude: 41.512987, longitude: -81.605153))
    static let Wade = PointOfInterest(name: "Wade", location : CLLocation(latitude: 41.512987, longitude: -81.605153), encounter : Quest.wadeQuest)
    static let FribleyQ = PointOfInterest(name: "Wade Quest End", location : CLLocation(latitude: 41.501288, longitude: -81.602810))
    static let Fribley = PointOfInterest(name: "Fribley", location : CLLocation(latitude: 41.501288, longitude: -81.602810), encounter : Quest.wadeQuest)
}

extension PointOfInterest: MKAnnotation {
    var coordinate: CLLocationCoordinate2D { return location.coordinate }
    var title: String? { return name }
}
