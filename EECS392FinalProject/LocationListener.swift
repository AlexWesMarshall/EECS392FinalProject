//
//  LocationListener.swift
//  EECS392FinalProject
//
//  Created by Samantha Frankum on 4/30/19.
//  Copyright © 2019 Alexander Marshall. All rights reserved.
//

import Foundation
import CoreLocation

class LocationListener: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.activityType = .other
        manager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        Game.shared.visitedLocation(location: lastLocation)
    }
}
