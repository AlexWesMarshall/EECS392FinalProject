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
    static let Sears = PointOfInterest(name: "Sears", location : CLLocation(latitude: 41.502789, longitude: -81.608062), isRegenPoint : false, encounter : Homework.Sears)
    static let KSL = PointOfInterest(name: "Lib Lab", location : CLLocation(latitude: 41.507266, longitude: -81.609636), isRegenPoint : false, encounter : Study.KSL)
    static let Tink = PointOfInterest(name: "University Center", location : CLLocation(latitude: 41.508165, longitude: -81.608554), isRegenPoint : false, encounter : Study.Tink)
    static let Veale = PointOfInterest(name: "Gym", location : CLLocation(latitude: 41.500997, longitude: -81.606147), isRegenPoint : false)
    static let EuclidStarbucks = PointOfInterest(name: "\"Energy\" Store", location : CLLocation(latitude: 41.508156, longitude: -81.605971), isRegenPoint : false, encounter : Starbucks.EuclidStarbucks)
    static let PBL = PointOfInterest(name: "Business Center", location : CLLocation(latitude: 41.509816, longitude: -81.607754), isRegenPoint : false, encounter : CanvasNotification.PBLNotification)
    static let Village = PointOfInterest(name: "Village", location : CLLocation(latitude: 41.512195, longitude: -81.603606), isRegenPoint : true)
    static let Wade = PointOfInterest(name: "Wade", location : CLLocation(latitude: 41.512987, longitude: -81.605153), isRegenPoint : false)
    static let Fribley = PointOfInterest(name: "Fribley", location : CLLocation(latitude: 41.501059, longitude: -81.602561), isRegenPoint : false)
}

extension PointOfInterest: MKAnnotation {
    var coordinate: CLLocationCoordinate2D { return location.coordinate }
    var title: String? { return name }
}
